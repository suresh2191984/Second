<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="RefundtoPatient.aspx.cs"
    Inherits="Patient_RefundtoPatient" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Refund or Cancel</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function OpenIframe(FinalBillID, patientVisitID) {
            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=DefaultPrint&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
        }
        function expandDropDownList1(elementRef) {
            elementRef.style.width = '400px';
        }

        function collapseDropDownList1(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
        
        
    </script>

    <style>
        #pnlas td, .amtDetails td, #pnlAssign td
        {
            padding: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <%--<asp:ServiceReference Path="~/InventoryWebService.asmx" />--%>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td class="v-top w-50p">
                            <asp:Panel ID="pnlas" runat="server" CssClass="dataheader3" GroupingText="Patient Details"
                                meta:resourcekey="pnlasResource1">
                                <table class="w-100p">
                                    <tr class="a-left">
                                        <td>
                                            <asp:Label ID="re_" Text="Patient No" runat="server" meta:resourcekey="re_Resource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="re_age" Text="Patient Age" runat="server" meta:resourcekey="re_ageResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="labAge" runat="server" meta:resourcekey="labAgeResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="re_sex" Text="Sex" runat="server" meta:resourcekey="re_sexResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lalSex" runat="server" meta:resourcekey="lalSexResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_BillNo" Text="Bill No " runat="server" meta:resourcekey="Rs_BillNoResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblInvoiceNo" runat="server" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="re_BillDate" Text="Bill Date " runat="server" meta:resourcekey="re_BillDateResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lalBillDate" runat="server" meta:resourcekey="lalBillDateResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="re_BilledBy" Text="BilledBy  " runat="server" meta:resourcekey="re_BilledByResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td colspan="4">
                                            <asp:Label ID="lalBilledBy" runat="server" meta:resourcekey="lalBilledByResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td class="a-top w-30p">
                            <asp:Panel ID="Panel1" runat="server" CssClass="dataheader3 amtDetails" GroupingText="Amount Details"
                                meta:resourcekey="Panel1Resource1">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblAmtReceivedText" runat="server" Text="Amount Received from the Patient is"
                                                meta:resourcekey="lblAmtReceivedTextResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotAmtReceived" CssClass="errormsg" runat="server" meta:resourcekey="lblTotAmtReceivedResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblAmtRefundedText" runat="server" Text="Amount Refunded to the Patient is "
                                                meta:resourcekey="lblAmtRefundedTextResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotAmtRefunded" CssClass="errormsg" runat="server" meta:resourcekey="lblTotAmtRefundedResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRefAmt" runat="server" Text="Refundable Amount is " meta:resourcekey="lblRefAmtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRefundableAmt" CssClass="errormsg" runat="server" meta:resourcekey="lblRefundableAmtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDiscount" runat="server" Text="Discount Amount" meta:resourcekey="lblDiscountResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lbltxtDiscountAmt" CssClass="errormsg" runat="server" meta:resourcekey="lbltxtDiscountAmtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDueAmt" runat="server" Text="Due Amount" meta:resourcekey="lblDueAmtResource1"></asp:Label>
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <asp:Label ID="lbltxtDueAmt" CssClass="errormsg" runat="server" meta:resourcekey="lbltxtDueAmtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:GridView ID="grdRefund" OnRowDataBound="grdRefund_RowDataBound" CellPadding="2"
                                AutoGenerateColumns="False" DataKeyNames="BillingDetailsID" ForeColor="#333333"
                                CssClass="mytable1 gridView w-100p" runat="server" meta:resourcekey="grdRefundResource1">
                                <RowStyle BackColor="White" HorizontalAlign="Left" Font-Bold="True" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                <Columns>
                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkSelectAll" runat="server" Visible="False" meta:resourcekey="chkSelectAllResource1" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRefund" runat="server" meta:resourcekey="chkRefundResource1" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("FeeDescription") %>'
                                                meta:resourcekey="lblDescriptionResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Billed Amount" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount","{0:0.00}") %>'
                                                meta:resourcekey="lblAmountResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount Amount" >
                                        <ItemTemplate>
                                            <asp:Label ID="lblDiscAmount" runat="server" Text='<%# Bind("DiscountAmount","{0:0.00}") %>'
                                                meta:resourcekey="lblDiscAmountResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Refundable Amount" meta:resourcekey="TemplateFieldResource8">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRefundableAmount" runat="server" ></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount Refunded" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRfdAmt" runat="server" Text='<%# Bind("RefundedAmt") %>' meta:resourcekey="lblRfdAmtResource1"></asp:Label></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount To Refund" meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:TextBox onblur="return sumAmount(this.id);"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                ID="TxtRfdAmt" Width="100px"  runat="server" meta:resourcekey="TxtRfdAmtResource1"></asp:TextBox></ItemTemplate><%--Text="0.00" --%>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reason" meta:resourcekey="TemplateFieldResource6">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlType" runat="server" Width="200px" normalWidth="200px" onmousedown="expandDropDownList1(this);"
                                                onblur="collapseDropDownList1(this);" meta:resourcekey="ddlTypeResource1">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Comments" meta:resourcekey="TemplateFieldResource7">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtComments" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr class="bg-row">
                        <td id="RefundtoPatient" style="display: none;" runat="server" colspan="2">
                            <asp:Label ID="lblRefundToPatient" runat="server" Text="Whether Refund to Patient : "
                                meta:resourcekey="lblRefundToPatientResource1"></asp:Label>
                            <asp:CheckBox ID="chbRefundPatient" runat="server" meta:resourcekey="chbRefundPatientResource1" />
                        </td>
                    </tr>
                    <tr class="bg-row">
                        <td id="tdAuthorizedBy" runat="server" colspan="2">
                            <asp:Label ID="lblAuthorised" runat="server" Text="Authorised By" Width="110px" meta:resourcekey="lblAuthorisedResource1"></asp:Label>
                            <asp:TextBox ID="txtAuthorised" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtAuthorisedResource1" />
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" TargetControlID="txtAuthorised"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="getUserNamesWithNameandLoginID"
                                OnClientItemSelected="Selected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                Enabled="True" UseContextKey="True">
                            </ajc:AutoCompleteExtender>
                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                    </tr>
                    <tr class="bg-row">
                        <td id="tdRefundTaskAssign" runat="server" colspan="2">
                            <asp:Panel ID="pnlCheckToAssign" runat="server" meta:resourcekey="pnlCheckToAssignResource1">
                                <table>
                                    <tr id="trTaskAssign" runat="server">
                                        <td id="Td8" runat="server">
                                            <asp:Label ID="Rs_TaskAssignTo" Text="Task Assign To Administrator" runat="server" meta:resourcekey="Rs_TaskAssignToResource1"></asp:Label>
                                        </td>
                                        <td id="Td9" runat="server">
                                            <asp:CheckBoxList ID="chkAssignTotask" onclick="javascript:dispTask(this.id);" runat="server">
                                            </asp:CheckBoxList>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr class="a-center v-middle">
                        <td class="a-center v-middle" colspan="2">
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Panel ID="pnlAssign" CssClass="dataheader3" GroupingText="Payment Details" runat="server"
                                meta:resourcekey="pnlAssignResource1">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_SelectModeofPayment" Text="Select Mode of Payment" runat="server"
                                                meta:resourcekey="Rs_SelectModeofPaymentResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rblPaymode" RepeatDirection="Horizontal"
                                                runat="server" meta:resourcekey="rblPaymodeResource1">
                                                <%--<asp:ListItem Selected="True" Value="1" Text="Cash" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Text="Cheque" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="Credit Note" Value="11" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_SelectPayingCurrency" Text="Select Paying Currency" runat="server"
                                                meta:resourcekey="Rs_SelectPayingCurrencyResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlBaseCurrency" ToolTip="Select Currency" runat="server" CssClass="ddlmedium"
                                                meta:resourcekey="ddlBaseCurrencyResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_RefundableAmountis" Text="Refundable Amount is:(" runat="server"
                                                meta:resourcekey="Rs_RefundableAmountisResource1"></asp:Label>
                                            <asp:Label ID="lblCurName" runat="server" meta:resourcekey="lblCurNameResource1"></asp:Label>)
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCurrChange" runat="server" meta:resourcekey="lblCurrChangeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="a-center">
                                            <div id="chequediv" runat="server" style="display: none">
                                                <table>
                                                    <tr class="a-center">
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_ChequeNo" Text="Cheque No." runat="server" meta:resourcekey="Rs_ChequeNoResource1"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_Bank" Text="Bank" runat="server" meta:resourcekey="Rs_BankResource1"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_Remarks" Text="Remarks" runat="server" meta:resourcekey="Rs_RemarksResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr class="a-center">
                                                        <td nowrap="nowrap">
                                                            <asp:TextBox runat="server" ID="txtNumber"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                autocomplete="off" Width="130px" MaxLength="19" meta:resourcekey="txtNumberResource1"></asp:TextBox>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:TextBox runat="server" ID="txtBankType" Width="220px" meta:resourcekey="txtBankTypeResource1"></asp:TextBox>
                                                            <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                                MinimumPrefixLength="1" ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx"
                                                                TargetControlID="txtBankType" DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>--%>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:TextBox ID="txtRemarks" runat="server" Width="150px" autocomplete="off" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdRefundTask" runat="server" class="a-center w-100p" colspan="2">
                            <table class="w-100p">
                                <tr id="trpnlRefund" runat="server">
                                    <td id="Td10" runat="server">
                                        <asp:Button ID="btnRefund" OnClientClick="return ChequeValidate();" Text="Submit"
                                            runat="server" CssClass="btn" OnClick="btnRefund_Click" meta:resourcekey="btnRefundResource1" />
                                        &nbsp;<asp:Button ID="btnCancel" Text="Close" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                                <tr runat="server" id="trpnlAssign" style="display: none;">
                                    <td id="Td11" runat="server">
                                        <asp:Button ID="btnTask" OnClientClick="return ChequeValidate();" Text="Create Task"
                                            runat="server" CssClass="btn" OnClick="btnRefund_Click" meta:resourcekey="btnTaskResource1" />
                                        &nbsp;<asp:Button ID="btnTaskCancel" Text="Close" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                            meta:resourcekey="btnTaskCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <div id="iframeBill1">
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnAuthorisedID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCurRefAmount" runat="server" />
    <asp:HiddenField ID="hdnTemprefAmount" runat="server" />
    <asp:HiddenField ID="hdnType" runat="server" />
    <asp:HiddenField ID="hdnfullcancel" runat="server" />
    <asp:HiddenField ID="hdnOldValues" runat="server" />
    <input type="hidden" runat="server" id="hdnReferenceType" />
    <input type="hidden" runat="server" id="IsCopayment" />
    <input type="hidden" runat="server" id="hdnHashealthcoupon" />
    <input type="hidden" runat="server" id="hdnCollectionID" />
    <asp:HiddenField ID="hdnIscreditBill" runat="server" />
	<asp:HiddenField ID="hdnCancelRestriction" runat="server" Value="N" />
    </form>

    <script type="text/javascript" language="javascript">
        var AlertType = "";

        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_13') == null ? "Alert" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_13');
        });
        function Selected(source, eventArgs) {
            document.getElementById('hdnAuthorisedID').value = '0';
            var Autoid = eventArgs.get_value();
            document.getElementById('hdnAuthorisedID').value = Autoid;
        }

        function Paymentchanged() {
            if (document.getElementById('rblPaymode_1').checked) {
                document.getElementById('chequediv').style.display = "block";
            }
            else {
                document.getElementById('chequediv').style.display = "none";
                document.getElementById('txtNumber').value = "";
                document.getElementById('txtBankType').value = "";
                document.getElementById('txtRemarks').value = "";
            }
        }
        function blacktext(e) {
            if (!((e.keyCode >= 48) && (e.keyCode <= 57))) {
                if (e.keyCode == 46) {
                    return true;
                }
                else {
                    e.keyCode = 0;
                }
            }
        }
        function sumAmount(ID) {
            var vValidationRefoundAmt = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_02') == null ? "Amount Can not be greater than Refundable Amount" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_02');
            var vValidateBillAmt = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_03') == null ? "Amount Can not be greater than Billed Amount" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_03');
            var BillType = getUrlVars()["btype"];
            var IsCreditBill = document.getElementById('hdnIscreditBill').value;
            var sum = 0;
            var lblBuildAmountId = ID.replace("TxtRfdAmt", "lblAmount")
            var s = ToInternalFormat($('#' + document.getElementById(ID).id));
            var lblReceiveAmountId = ID.replace("TxtRfdAmt", "lblRfdAmt")
            var lblRefundableAmountId = ID.replace("TxtRfdAmt", "lblRefundableAmount")       
            var BulidAmount = ToInternalFormat($('#' + document.getElementById(lblBuildAmountId).id));
            var ReceivedAmount = ToInternalFormat($('#' + document.getElementById(lblReceiveAmountId).id));
            var RefundableAmount = ToInternalFormat($('#' + document.getElementById(lblRefundableAmountId).id));
            BulidAmount = Number(RefundableAmount) - Number(ReceivedAmount);
            if (BulidAmount >= Number(s)) {
                if (s == "" || s == 0) {
                    document.getElementById(ID).value = "0.00";
                    ToTargetFormat($('#' + document.getElementById(ID).id));
                }
                var refAmt = ToInternalFormat($('#lblRefAmt'));
                var temp = document.getElementById('hdnTemprefAmount').value;
                var stemp = temp.split('~');
                for (var i = 0; i < stemp.length; i++) {
                    if (stemp[i] != "") {
                        sum = parseFloat(sum) + parseFloat(ToInternalFormat($('#' + document.getElementById(stemp[i]).id)));
                    }

                }
                var roundoff = 0;
                if (ToInternalFormat($('#hdnRoundOff')) != undefined) {
                    ToInternalFormat($('#hdnRoundOff'));
                }
                document.getElementById('hdnCurRefAmount').value = sum;
                ToTargetFormat($('#hdnCurRefAmount'));
                if (document.getElementById('lblCurrChange') != null) {
                    document.getElementById('lblCurrChange').innerHTML = "";
                    document.getElementById('lblCurrChange').innerHTML = parseFloat(sum).toFixed(2);
                    //   document.getElementById('txtAmount').value = parseFloat(sum).toFixed(2);
                    ToTargetFormat($('#lblCurrChange'));
                    //   ToTargetFormat($('#txtAmount'));
                }
                if (Math.round(ToInternalFormat($('#lblTotAmtReceived'))) == Math.round(sum)) {
                    var addround = parseFloat(parseFloat(sum) + parseFloat(roundoff)).toFixed(2);
                    if (document.getElementById('lblCurrChange') != null) {
                        document.getElementById('lblCurrChange').innerHTML = "";
                        document.getElementById('lblCurrChange').innerHTML = addround;
                        //   document.getElementById('txtAmount').value = addround;
                        ToTargetFormat($('#lblCurrChange'));
                        // ToTargetFormat($('#txtAmount'));
                    }
                }
                var crrchange = document.getElementById('lblCurrChange').innerHTML;
                var TotAmtRefunded = document.getElementById('lblRefundableAmt').innerHTML;
                if (BillType == 'CAN' && document.getElementById('hdnIscreditBill').value == "Y") {
                    document.getElementById('lblCurrChange').value = "0.00"
                    document.getElementById(ID).value = "0.00";
                    return true;
                }
                if (parseFloat(crrchange) <= parseFloat(TotAmtRefunded)) {
                    return true;
                }
                else {
                    ValidationWindow(vValidationRefoundAmt, AlertType);
                    //  document.getElementById(ID).focus();
                    document.getElementById(ID).value = "0.00";
                    return false;
                }
            }
            else {
                ValidationWindow(vValidationRefoundAmt, AlertType);
                //document.getElementById(ID).focus();
                document.getElementById(ID).value = "0.00";
                return false;
            }

        }
        function dispTask(id) {
            var flag = 0;
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {
                    flag = 1;
                    break;
                }
            }
            if (flag == 1) {
                document.getElementById('trpnlAssign').style.display = "block";
                document.getElementById('trpnlRefund').style.display = "none";

                if (document.getElementById('pnlAssign') != undefined) {
                    document.getElementById('pnlAssign').style.display = "none";
                }
                document.getElementById('rblPaymode_0').checked = true;
            }
            else {
                document.getElementById('trpnlAssign').style.display = "none";
                document.getElementById('trpnlRefund').style.display = "block";

                if (document.getElementById('pnlAssign') != undefined) {
                    document.getElementById('pnlAssign').style.display = "block";
                }
            }
        }

        function getUrlVars() {
            var vars = {};
            var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m, key, value) {
                vars[key] = value;
            });
            return vars;
        }
        function ChequeValidate() {
            var vPersonName = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_04') == null ? "Please provide the Authorised person name" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_04');
            var vBillItem = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_05') == null ? "Please Select all Bill Item" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_05');
            var vAlredyRefund = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_06') == null ? "Already amount refunded" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_06');
            var vSelectBillItem = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_07') == null ? "Please Select atleast one Bill Item" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_07');
            var vSelectItemAmt = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_08') == null ? "Please enter the selected items amount" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_08');
            var vValidateAmtAlert = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_09') == null ? "Do you want to the Cancel Amount?" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_09');
            var vValidateRefundAmtAlert = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10') == null ? "Do you  want to the Refund the Amount?" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10');

            if (document.getElementById('hdnAuthorisedID').value == '0' || document.getElementById('txtAuthorised').value == "") {
                var userMsg = SListForApplicationMessages.Get('Patient\\RefundtoPatient.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    document.getElementById('txtAuthorised').focus();
                    return false;
                }
                else {
                    //alert('Please provide the Authorised person name');
                    ValidationWindow(vPersonName, AlertType);
                    //document.getElementById('txtAuthorised').focus();
                    return false;
                }
            }
            //Cancellation Restriction -- Seetha

            if (document.getElementById('hdnCancelRestriction').value == 'Y') {
                var CancellationAlert = 'Cannot Cancel this bill, because invoice cycle is exceeded.';
                ValidationWindow(CancellationAlert, AlertType);
                return false;
            }

            //Cancellation Restriction -- Seetha
            var BillType = getUrlVars()["btype"]; ///Use For Get Querystring Value
            var grid = document.getElementById('grdRefund');
            var len1 = grid.rows.length-1;
            var flag = 0;
            var Count = 0;
            var Chkcount = 0;
            var Chkno = 0;
            //            debugger
            //            var refundableAmt = ToInternalFormat($('#' + document.getElementById('lblRefundableAmt').id));
            //            var totalAmt = ToInternalFormat($('#' + document.getElementById('lblCurrChange').id));
            var a;
            var RowCheckedCount=0;
            if (len1 > 0) {
                Chkcount = $(':checkbox:checked').length;
                $('#grdRefund').find('input:checkbox[id$="chkRefund"]').each(function() {
                    var isChecked = $(this).prop("checked");
                    var isText = $(this).attr('id').replace('chkRefund', 'TxtRfdAmt');
                    var txtValue = $("input#" + isText + "").val();
                   
                    if (isChecked) {
                        flag = 1;
                        a = sumAmount(isText);
                        RowCheckedCount = RowCheckedCount + 1;
                    }
                    if (isChecked == true && txtValue == '0.00' && BillType != 'CAN') {
                        Count = 1;
                    }
                });
            }
            if (document.getElementById('hdnfullcancel').value == 'Y') {
                if (document.getElementById('RefundtoPatient').style.display == 'none') {
                    //Chkno = Chkcount;
                    Chkno = RowCheckedCount;
                }
                else { 
				//Chkno = Chkcount - 1;
				Chkno = RowCheckedCount;
				 }
                if (len1 == Chkno) {
                }
                else {
                    ValidationWindow(vBillItem, AlertType);
                    return false;
                }
            }
            if (a == true) {
            if (document.getElementById('IsCopayment').value == 'Y') {

                if (document.getElementById('RefundtoPatient').style.display == 'none') { }
                else { Chkcount = Chkcount - 1; }
                len1 = len1 - 1;
                if (Chkcount == len1) {

                } else {
                    var lblRefundableAmt = document.getElementById('lblRefundableAmt').innerHTML;
                    var lblTotAmtReceived = document.getElementById('lblTotAmtReceived').innerHTML;
                    var lblTotAmtRefunded = document.getElementById('lblTotAmtRefunded').innerHTML;
                    if (parseFloat(lblRefundableAmt) > 0) {
                        //alert('Please Select all Bill Item');
                        ValidationWindow(vBillItem, AlertType);
                        return false;
                    }
                    else if (parseFloat(lblTotAmtRefunded) > 0) {
                        //alert('Already amount refunded');
                        ValidationWindow(vAlredyRefund, AlertType);
                        return false;
                    }
                }
            }

            if (flag == 0) {
                var userMsg = SListForApplicationMessages.Get('Patient\\RefundtoPatient.aspx_18');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    //alert('Please Select atleast one Bill Item');
                    ValidationWindow(vSelectBillItem, AlertType);
                    return false;
                }
            }
            else if (Count == 1) {
                //alert("Please enter the selected items amount");
                ValidationWindow(vSelectItemAmt, AlertType);
                return false;
            }

            if (BillType == 'CAN') {
                var AlertMsg = vValidateAmtAlert;
            }
            else {
                AlertMsg = vValidateRefundAmtAlert;
            }
            var response = window.confirm(AlertMsg);
            if (response) {
                return true;
                }
                else {
                    return false;
                }
            }
            else {
                ValidationWindow(vSelectBillItem, AlertType);
                return false;
            }
        }

        function SelectAll(obj) {
            if (document.getElementById("<%= grdRefund.ClientID %>") != null) {
                var gridId = document.getElementById("<%= grdRefund.ClientID %>");
                var gdrowcount = document.getElementById("<%= grdRefund.ClientID %>").rows.length;
                for (var i = 1; i < gdrowcount; i++) {
                    var inputs = gridId.rows[i].getElementsByTagName('input');
                    for (var j = 0; j < inputs.length; j++) {
                        if (document.getElementById(obj).checked == true) {
                            inputs[j].checked = true;
                        }
                        else {
                            document.getElementById(obj).checked == false;
                            inputs[j].checked = false;
                        }
                    }
                }
            }
        }

        function SetTotalAmount(Id, obj) {
            var BillType = getUrlVars()["btype"];
            var count = 0;
            if (BillType == "CAN") {
                var gridId = document.getElementById("<%= grdRefund.ClientID %>");
                var gdrowcount = document.getElementById("<%= grdRefund.ClientID %>").rows.length;
                var headercheck = gridId.rows[0].getElementsByTagName('input');
                for (var i = 1; i < gdrowcount; i++) {
                    var inputs = gridId.rows[i].getElementsByTagName('input');
                    for (var j = 0; j < inputs.length; j++) {
                        if (inputs[j].checked == true) {
                            count++;
                        }
                    }
                }
                if (gdrowcount - 1 == count) {
                    headercheck[0].checked = true;
                }
                else {
                    headercheck[0].checked = false;
                }
            }
        }
      function ValidationWindowCustom1(message, tt, url) {
            //var def = $.Deferred();
            jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        redirect(url);
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");

            }
        }).dialog("open");
            return false;
            // return def.promise();
        }
        function redirect(url) {
            path = url + '&isPopup=Y';
            window.location.href = path;
            return false;
        }
        function ValidationWindowCustom(message, tt, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) {
            //var def = $.Deferred();
            jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11);
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }
                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");

            }
        }).dialog("open");
            return false;
            // return def.promise();
        }
        function getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) {
            //   var vValidateRefundAmtAlert = SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10') == null ? "Do you wish to take Print?" : SListForAppMsg.Get('Patient_RefundtoPatient_aspx_10');
            var objvarAlert = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_13") == null ? "Alert" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_13");
            var i;
            var objvar13 = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_16") == null ? "Do you wish to take Print?" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_16");
            var btnoktext = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_14") == null ? "OK" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_14");
            var btnclosetext = SListForAppMsg.Get("Patient_RefundtoPatient_aspx_15") == null ? "Close" : SListForAppMsg.Get("Patient_RefundtoPatient_aspx_15");
            var ans;
            var a;
            var oldpath = window.location.href;
            var curpath = window.location.href;
            a = curpath.indexOf("WebApp");
            curpath = curpath.substring(0, a);
            //ans = window.confirm('Do you wish to take Print?');
            ans = ConfirmWindow(objvar13,objvarAlert,btnoktext,btnclosetext);
            if (ans == true) {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                strFeatures = strFeatures + ",left=0,top=0";

                var strURL = "../Billing/RefundVoucher.aspx?BillNo="
               + v1
               + "&BilledAmt=" + v2
               + "&Name=" + v3
               + "&PNumber=" + v4
               + "&IsPopup=Y"
               + "&RefundAmount=" + v5
               + "&RefundVoucherNo=" + v6
               + "&VID=" + v7
               + "&PatientID=" + v8
               + "&btype=" + v9
               + "&FinallBillID=" + v10
               + "&RefFlag=" + v11;
                window.open(strURL, "", strFeatures, true);
            }
            else {
            }
        }
    </script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function ToInternalFormat(pControl) {
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

</body>
</html>
