<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceReceiptOfflinePayment.aspx.cs"
    Inherits="Ledger_InvoiceReceiptOfflinePayment" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Invoice Receipt Offline Payment</title>
    <style type="text/css">
        .schedule_title
        {
            color: #fff;
            text-align: center;
            font-weight: bold;
            background: #3D667F;
            text-align: center;
            padding: 10px 0;
        }
        .scheduledataheader2
        {
            background: #d8dfd8;
            width: 452px;
            margin: 0px auto 0 !important;
            border: 0.12em solid #446d87;
            padding: 15px;
        }
        .scheduledataheader3
        {
            width: 420px;
            min-height: 100px;
            background: #d8dfd8;
            margin: 0px auto 0 !important;
            border: 0.12em solid #446d87;
            padding: 15px;
        }
        #DivLpwd table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivRpwd table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivCash table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivCheque table tr td span
        {
            font-weight: bold;
            box-shadow: none !important;
            font-family: arial;
        }
        #DivRpwd.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
        #DivCash.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
        #DivCheque.scheduledataheader2
        {
            margin: 50px auto 0;
            padding: 15px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet"
        type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <%--<div id="pendingProgress" style="display: none;">
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </div>--%>
    <div class="contentdata">
        <%--<asp:UpdatePanel ID="UdtPanel" runat="server">
            <ContentTemplate>--%>
        <%--</div>--%>
        <div class="schedule_title" id="DivReciept">
            INVOICE OFFLINE RECIEPT ENTRY
        </div>
        <br />
        <div class="scheduledataheader3 a-center" id="divAdvanceProceed" runat="server">
            <table>
                <tr>
                    <td width="20%">
                    </td>
                    <td width="80%">
                        <table>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblBilanount" runat="server" Font-Bold="true" Text="Billing Amount"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:TextBox ID="txtAmount" runat="server" autocomplete="off" CssClass="medium" ReadOnly="true"
                                        Width="100px" Enabled="false" Font-Bold="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lbladvanceAmount" runat="server" Text="Advance" Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left" align="left">
                                    <asp:CheckBox ID="chkAdvanceSelect" runat="server" onclick="javascript:return Select(this.id);" />
                                    <asp:TextBox ID="txtAdvanceAmount" runat="server" Width="100px" autocomplete="off"
                                        CssClass="medium" Enabled="false" ReadOnly="true" Font-Bold="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="txtpayamoutn" runat="server" Text="Pay Amount" Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:TextBox ID="txtPayAmount" runat="server" autocomplete="off" Width="100px" CssClass="medium"
                                        ReadOnly="true" Enabled="false" Font-Bold="true"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr id="trReminingAdv" runat="server" style="display: none" height="20px">
                                <td nowrap="nowrap" align="left">
                                    <b>Remaining Advance</b>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="lblBalanceAdvance" runat="server" Text="0" Font-Bold="true" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="3">
                                    <br />
                                    <asp:Button ID="btnProceed" runat="server" Text="ProccedPay" CssClass="btn" OnClick="btnProccedPay_Click"
                                        Style="display: none" />
                                    &nbsp;
                                    <%--<asp:Button ID="btnCancelbtnProccedPay" runat="server" Text="Cancel" CssClass="btn"
                            OnClick="btnCancelbtnProccedPay_Click" />--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10%">
                    </td>
                </tr>
            </table>
        </div>
        <div class="scheduledataheader2 a-center" id="DivRpwd" runat="server">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-left w-35p" nowrap="nowrap">
                        <asp:Label ID="lblRClientName" runat="server" Text="TSP Code"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:HiddenField ID="hdnRClientid" runat="server" />
                        <asp:TextBox ID="txtRClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtRClientName"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                            OnClientItemSelected="SetRClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                            OnClientItemOver="SelectedClient" Enabled="True">
                        </cc1:AutoCompleteExtender>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left w-35p" nowrap="nowrap">
                        <asp:Label ID="lblPaymentDetails" runat="server" Text=" Payment Details" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                            onclick="enablecashcheque()" runat="server">
                            <asp:ListItem Text="Cash" Selected="True" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Cheque" Value="1"></asp:ListItem>
                            <asp:ListItem Text="DD" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Bank Deposit" Value="3"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <%-- ---Murali----%>
        <div class="scheduledataheader2 a-center" id="DivCheque" runat="server" style="display: none">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblBankName" runat="server" Text="Bank Name"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtBankName" Width="78%" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequePhysicalReceiptNo" runat="server" Text="Physical Receipt No."></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequePhysicalReceiptNo" Width="78%" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequedate" runat="server" Text="Date"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequedate" Width="78%" MaxLength="25" size="20" CssClass="datePicker"
                            runat="server" onchange="FromDateCheck1();"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequeAmount" runat="server" Text="Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequeAmount" Width="78%" runat="server" MaxLength="8" Enabled="false"
                            onblur="validateChequeAmount()" onkeypress="return NumbersOnly(event);"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr style="display: none;">
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequeEnterAmount" runat="server" Text="Re-Enter Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequeEnterAmount" Width="78%" runat="server" MaxLength="8" onblur="validateChequeAmount()"
                            onkeypress="return NumbersOnly(event);"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequeNumber" runat="server" Text="Cheque/DD Number"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequeNumber" Width="78%" runat="server" onblur="ChequeNoValidation()"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblReChequeNumber" runat="server" Text="Re-Cheque/DD Number"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtReChequeNumber" Width="78%" runat="server" onblur="ChequeNoValidation()"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblChequeRemarks" runat="server" Text="Remarks"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequeRemarks" runat="server" TextMode="MultiLine" MaxLength="200"
                            Width="160px" onKeyUp="Count(this,200)" onChange="Count(this,200)"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblProofCopy" runat="server" Text="Proof Copy"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:FileUpload ID="fpProofCopy" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG"
                            ToolTip="Upload GIF,JPG,PNG,BMP and JPEG images only" /><%--&nbsp;<input id="btnAdd"
                            style="width: 60px" type="button" runat="server"
                            value="Add" title="Add GIF,JPG,PNG,BMP and JPEG images only" />&nbsp;<input id="btnClear"
                                style="width: 60px" type="button" value="Clear"
                                runat="server" visible="false" /> <ul id="ulList"> </ul>--%>
                        <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="fpProofCopy"
                            ErrorMessage=".jpg, .gif,.png & .jpeg formats are allowed" ValidationExpression="(.+\.([Jj][Pp][Gg])|.+\.([Pp][Nn][Gg])|.+\.([Gg][Ii][Ff])|.+\.([Jj][Pp][Ee][Gg]))">

                        </asp:RegularExpressionValidator>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Button ID="btnChequeSubmit" runat="server" Text="Submit" OnClientClick="javascript:return Chequevalidate()"
                            CssClass="btn" OnClick="btnChequeSubmit_Click" />
                        &nbsp;
                        <asp:Button ID="btnChequeReset" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCashReset_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="scheduledataheader2 a-center" id="DivCash" runat="server">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblcashPhysicalReceiptNo" runat="server" Text="Physical Receipt No."></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtcashPhysicalReceiptNo" Width="78%" MaxLength="8" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashDate" runat="server" Text="Date"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashDate" Width="78%" MaxLength="25" size="20" CssClass="datePicker"
                            onchange="FromDateCheck();" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashAmount" runat="server" Text="Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashAmount" Width="78%" MaxLength="8" runat="server" onblur="validateCashAmount()"
                            onkeypress="return NumbersOnly(event);"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr style="display: none;">
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashReAmount" runat="server" Text="Re-Enter Amount"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashReAmount" Width="78%" MaxLength="8" onblur="validateCashAmount()"
                            onkeypress="return NumbersOnly(event);" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 3px;">
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblCashRemarks" runat="server" Text="Remarks"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtCashRemarks" runat="server" TextMode="MultiLine" MaxLength="200"
                            Width="160px" onKeyUp="Count(this,200)" onChange="Count(this,200)"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
                <tr>
                    <td class="emptyrow">
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td class="w-40p">
                    </td>
                    <td>
                        <table class="w-50p">
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnCashSubmit" runat="server" Text="Submit" OnClientClick="javascript:return Cashvalidate()"
                                        OnClick="btnCashSubmit_Click" CssClass="btn" />
                                </td>
                                <td class="a-center">
                                    <asp:Button ID="btnCashAdvence" runat="server" Text="Procced" CssClass="btn" OnClick="btnCashAdvence_Click"
                                        Style="display: none" OnClientClick="javascript:return Redirect()" />
                                </td>
                                <td class="a-center">
                                    <asp:Button ID="btnCashReset" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCashReset_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="5%">
                    </td>
                </tr>
            </table>
        </div>
        <%--</ContentTemplate> </asp:UpdatePanel>--%>
    </div>
    <asp:HiddenField ID="hdnBarcodeNumber" runat="server" />
    <asp:HiddenField ID="hdnPaymentType" runat="server" />
    <asp:HiddenField ID="hdnClientLoginID" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnDrivePath" runat="server" />
    <%--  <asp:HiddenField ID="handlerpath" runat="server" /> value="F:\\ReceiptEntryImages\\"  --%>
    <asp:HiddenField ID="FileName" runat="server" />
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function NumbersOnly(e) {
            var charCode = e.charCode ? e.charCode : e.keyCode
            if (charCode != 8 && charCode != 9) {
                if (charCode < 48 || charCode > 57)
                    return false
            }
        }
        function Redirect() {
            alert('Advance amount Use for payment was successful');
            window.location.href = "../Ledger/InvoicePayment.aspx";
            return true;
        }
          
    </script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            // GetNattation();
            // enableEntry();

        });

        function ClearData() {
            document.getElementById('txtEnterBarCode').value = "";
            document.getElementById('txtReEnterBarCode').value = "";
            document.getElementById('txtEnterAmount').value = "";
            document.getElementById('txtReEnterAmount').value = "";
            document.getElementById('txtRemarks').value = "";
        }


        function Reset() {
            //document.getElementById('ddlEntrytype').SelectedItem == "C"
            document.getElementById('txtRClientName').value = '';
            document.getElementById('hdnRClientid').value = '';
            document.getElementById('txtcashPhysicalReceiptNo').value = '';
            document.getElementById('txtCashAmount').value = '';
            document.getElementById('txtCashReAmount').value = '';
            document.getElementById('txtCashRemarks').value = '';
            document.getElementById('txtChequePhysicalReceiptNo').value = '';
            document.getElementById('txtBankName').value = '';
            document.getElementById('txtChequeNumber').value = '';
            document.getElementById('txtReChequeNumber').value = '';
            document.getElementById('txtChequeEnterAmount').value = '';
            document.getElementById('txtChequeAmount').value = '';
            document.getElementById('txtChequeRemarks').value = '';
            //window.location.href = "../Ledger/ClientCreditDebit.aspx";
            return true;
        }
    </script>

    <script language="javascript" type="text/javascript">

        function SelectedClient(source, eventArgs) {
            $find('AutoCompleteExtender2')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender2')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtRClientName').value = '';
                    document.getElementById('<%=hdnRClientid.ClientID %>').value = '';
                }
            };
        }
        function SetRClientID(source, eventArgs) {
            // alert(eventArgs.get_value());
            var list = eventArgs.get_value().split('^');
            document.getElementById('<%=hdnRClientid.ClientID %>').value = list[3];

        }
    </script>

    <script language="javascript" type="text/javascript">
        /* Selva Start  */
        function FromDateCheck() {
            if ($("#txtCashDate").val() != null) {
                if ($("#txtCashDate").val() != '') {
                    var obj = $("#txtCashDate").val();

                    var currentTime;
                    if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                        dobDt = obj.split('/');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        var CurrentFullDate = day + "/" + month + "/" + year;
                        if (mYear == year && mMonth == month && mDay > day) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtCashDate").val(CurrentFullDate);
                            //$("#txtFrom").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

        }

        function FromDateCheck1() {
            if ($("#txtChequedate").val() != null) {
                if ($("#txtChequedate").val() != '') {
                    var obj = $("#txtChequedate").val();

                    var currentTime;
                    if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                        dobDt = obj.split('/');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        var CurrentFullDate = day + "/" + month + "/" + year;
                        if (mYear == year && mMonth == month && mDay > day) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtChequedate").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtChequedate").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtChequedate").val(CurrentFullDate);
                            //$("#txtFrom").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

        }
        /* Selva End  */
        function enablecashcheque() {
            if (document.getElementById('rblVisitType_1').checked == true || document.getElementById('rblVisitType_2').checked == true) {
                document.getElementById("DivCheque").style.display = 'block';
                document.getElementById("DivCash").style.display = 'none';
            }
            else {
                document.getElementById("DivCash").style.display = 'block';
                document.getElementById("DivCheque").style.display = 'none';

            }
            /* Selva Start  */
            if (document.getElementById('rblVisitType_3').checked == true) {
                document.getElementById("DivCheque").style.display = 'block';
                document.getElementById("DivCash").style.display = 'none';
                $('[id$=lblChequeNumber]').text('Document Number');
                $('[id$=lblReChequeNumber]').text('Re-Document Number');
            }
            else {
                $('[id$=lblChequeNumber]').text('Cheque/DD Number');
                $('[id$=lblReChequeNumber]').text('Re-Cheque/DD Number');
            }
            /* Selva End  */

        }

        function validateChequeAmount() {
            var enteredAmount = document.getElementById("<%=txtChequeAmount.ClientID%>").value;
            var ReEnteredAmount = document.getElementById("<%=txtChequeEnterAmount.ClientID%>").value;
            if (enteredAmount != '' && ReEnteredAmount != '') {
                if (enteredAmount != ReEnteredAmount) {
                    alert("Amount not matched");
                    document.getElementById("<%=txtChequeAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtChequeEnterAmount.ClientID%>").value = "";
                    return false;
                }
            }
        }
        function validateCashAmount() {
            var enteredAmount = document.getElementById("<%=txtCashAmount.ClientID%>").value;
            var ReEnteredAmount = document.getElementById("<%=txtCashReAmount.ClientID%>").value;
            if (enteredAmount != '' && ReEnteredAmount != '') {
                if (enteredAmount != ReEnteredAmount) {
                    alert("Amount not matched");
                    document.getElementById("<%=txtCashAmount.ClientID%>").value = "";
                    document.getElementById("<%=txtCashReAmount.ClientID%>").value = "";

                    return false;
                }
            }
        }
        function ChequeNoValidation() {
            var enteredNo = document.getElementById("<%=txtChequeNumber.ClientID%>").value;
            var ReEnteredNo = document.getElementById("<%=txtReChequeNumber.ClientID%>").value;
            if (enteredNo != '' && ReEnteredNo != '') {
                if (enteredNo != ReEnteredNo) {
                    alert("Cheque No not matched");
                    document.getElementById("<%=txtChequeNumber.ClientID%>").value = "";
                    document.getElementById("<%=txtReChequeNumber.ClientID%>").value = "";

                    return false;
                }
            }
        }

        function Cashvalidate() {

            if (document.getElementById("<%=txtRClientName.ClientID%>").value == "" || document.getElementById("<%=txtRClientName.ClientID%>").value == "0") {
                alert("Select the TSP Code");
                document.getElementById("<%=txtRClientName.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtcashPhysicalReceiptNo.ClientID%>").value == "" || document.getElementById("<%=txtcashPhysicalReceiptNo.ClientID%>").value == "Select") {
                alert("Select the PhysicalReceiptNo");
                document.getElementById("<%=txtcashPhysicalReceiptNo.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=txtCashAmount.ClientID%>").value == "") {
                alert("Enter the Amount ");
                document.getElementById("<%=txtCashAmount.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtCashRemarks.ClientID%>").value == "") {
                alert("Remarks should not be empty");
                document.getElementById("<%=txtCashRemarks.ClientID%>").focus();
                return false;
            }

            SaveReceipt();
            return true;
        }

        function Chequevalidate() {

            if (document.getElementById("<%=txtRClientName.ClientID%>").value == "" || document.getElementById("<%=txtRClientName.ClientID%>").length > 0) {
                alert("Select the TSP Code");
                document.getElementById("<%=txtRClientName.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtBankName.ClientID%>").value == "" || document.getElementById("<%=txtBankName.ClientID%>").value == "0") {
                alert("Select the Bank Name");
                document.getElementById("<%=txtBankName.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtChequePhysicalReceiptNo.ClientID%>").value == "" || document.getElementById("<%=txtChequePhysicalReceiptNo.ClientID%>").value == "Select") {
                alert("Select the PhysicalReceiptNo");
                document.getElementById("<%=txtChequePhysicalReceiptNo.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=txtChequeAmount.ClientID%>").value == "") {
                alert("Enter the Amount ");
                document.getElementById("<%=txtChequeAmount.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtChequeNumber.ClientID%>").value == "") {
                alert("Enter the Cheque Number ");
                document.getElementById("<%=txtChequeNumber.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=txtReChequeNumber.ClientID%>").value == "") {
                alert("Enter the ReEnter Cheque Number");
                document.getElementById("<%=txtReChequeNumber.ClientID%>").focus();
                return false;
            }


            if (document.getElementById("<%=txtChequeRemarks.ClientID%>").value == "") {
                alert("Remarks should not be empty");
                document.getElementById("<%=txtChequeRemarks.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=fpProofCopy.ClientID%>").value == "") {
                alert("Please Select file name");
                document.getElementById("<%=fpProofCopy.ClientID%>").focus();
                return false;
            }
            SaveReceipt();
            return true;
        }
    </script>

    <script language="javascript" type="text/javascript">

        function imagesave(succescode) {
        
            var fileUpload = $("#fpProofCopy").get(0);
            var files = fileUpload.files;
            var fileName;
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            var fp = $("#fpProofCopy");
            var lg = fp[0].files.length; // get length
            var items = fp[0].files;
            if (lg > 0) {
                for (var i = 0; i < lg; i++) {
                    fileName = items[i].name; // get file name
                }
            }

            // document.getElementById('hdnDrivePath').value = GetConfigValue("ReceiptEntryProofPath", OrgID);
            var FolderName = document.getElementById('hdnDrivePath').value;
            var OrgID = parseInt(document.getElementById('hdnOrgID').value);
            var SourceCode = document.getElementById('hdnRClientid').value;
            var PaymentReceiptNo = document.getElementById('txtChequePhysicalReceiptNo').value;
            //var filenamepath = SourceCode + "_" + PaymentReceiptNo + "_"; //FolderName +


            document.getElementById('FileName').value = fileName;
            //var folder;
            $.ajax({
            url: "AjaxFileHandler.ashx?fname=" + FolderName + "&SCRN=" + SourceCode + "_" + succescode + "_INVRCPT",
                type: "POST",
                data: data,
                //data: "{filenamepath:'" + filenamepath + "','FolderName':'" + FolderName + "'}",
                //data: "{ 'filepath' : 'myFileName' }",  //new                                 
                //contentType: "application/json; charset=utf-8",//new
                contentType: false,
                processData: false,
                //dataType: "json",//new
                success: function(result) {

                    //folder = result;
                    // folder = result(path);
                    //alert('Photocopy Uploaded successfully');
                },
                error: function(err) {
                    alert(err.statusText)
                }
            });
            /* Selva End  */

        }


        function SaveReceipt() {
            var fileUpload = $("#fpProofCopy").get(0);
            var files = fileUpload.files;
            var fileName;
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            var fp = $("#fpProofCopy");
            var lg = fp[0].files.length; // get length
            var items = fp[0].files;
            if (lg > 0) {
                for (var i = 0; i < lg; i++) {
                    fileName = items[i].name; // get file name
                }
            }
            document.getElementById('FileName').value = fileName;
            //document.getElementById('hdnDrivePath').value = GetConfigValue("ReceiptEntryProofPath", OrgID);
            var FolderName = document.getElementById('hdnDrivePath').value;
            //var FolderName = document.getElementById('handlerpath').value;
            var FiName = document.getElementById('FileName').value;

            var OrgID = parseInt(document.getElementById('hdnOrgID').value);
            var SourceCode = document.getElementById('hdnRClientid').value;
            var CreatedBy = document.getElementById('hdnClientLoginID').value;
            var CreatedAt = document.getElementById('hdnDate').value;
            var UsedPaymentType = document.getElementById('hdnPaymentType').value;
            if (UsedPaymentType == 'BILLWISE') {
                if (document.getElementById('rblVisitType_1').checked == true || document.getElementById('rblVisitType_2').checked == true || document.getElementById('rblVisitType_3').checked == true) {
                    var Paymenttype;
                    if (document.getElementById('rblVisitType_1').checked == true) {
                        Paymenttype = 'Cheque';
                    }
                    /* Selva Start  */
                    else if (document.getElementById('rblVisitType_2').checked == true) {
                        Paymenttype = 'DD';
                    }
                    else if (document.getElementById('rblVisitType_3').checked == true) {
                        Paymenttype = 'Bank Deposit';
                    }
                    /* Selva End  */
                    var PaymentReceiptNo = document.getElementById('txtChequePhysicalReceiptNo').value;
                    var BankName = document.getElementById('txtBankName').value;
                    var ChequeNumber = document.getElementById('txtChequeNumber').value;
                    var Amount = parseFloat(document.getElementById('txtChequeAmount').value);
                    var Remarks = "ResponseCode: 0, ResponseMsg: " + Paymenttype + " Deposited, TxnId: " + PaymentReceiptNo;
                    var ManualRemarks = document.getElementById('txtChequeRemarks').value;
                    var filenamepath = SourceCode + "_" + PaymentReceiptNo + "_" + FiName; //get clientcode,receipt no and filname
                    var Address = FolderName + filenamepath; //'F:|ReceiptEntryImages|' + filenamepath; ////FolderName + 
                    var Chequedatetemp = document.getElementById('txtChequedate').value;
                    var chunks = Chequedatetemp.split('/');
                    var Chequedate = chunks[1] + '/' + chunks[0] + '/' + chunks[2];

                    var lstClientReceipt = [];
                    lstClientReceipt.push({
                        OrgID: OrgID,
                        SourceCode: SourceCode,
                        BankName: BankName,
                        ChequeNo: ChequeNumber,
                        Mode: 'Offline',
                        PaymentType: Paymenttype,
                        PaymentReceiptNo: PaymentReceiptNo,
                        Amount: Amount,
                        ResponseCode: '1',
                        Remarks: Remarks,
                        ManualRemarks: ManualRemarks,
                        CreatedBy: CreatedBy,
                        ReceiptDate: Chequedate
                    });
                    var ClientReceipt = JSON.stringify(lstClientReceipt);
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/SaveInvoiceOfflineReceipt",
                        contentType: "application/json;charset=utf-8",
                        data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "','Orgid':'" + OrgID + "'}",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var succescode = data.d;
                            //                            if (succescode == -1) {
                            //                                //imagesave().kill;
                            //                                alert('Please Enter the Correct PaymentReceiptNo')
                            //                                Reset();
                            //                            }
                            //                            if (succescode == -2) {
                            //                                alert('Please Enter the Correct ChequeNo')
                            //                                Reset();
                            //                            }

                            if (succescode > 0) {
                                imagesave(succescode);
                                alert('Receipt Sumitted Successfully!');
                                //Reset();
                                // window.location = "http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/InvoicePayment.aspx";
                                window.location = "http://appvm1.cloudapp.net/Lims_Product/Ledger/InvoicePayment.aspx";


                            }
                            else {
                                alert('Error Exist!');
                                Reset();
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            debugger;
                            alert("Error");
                            return false;
                        }
                    });
                }
                else {
                    //var PaymentType = $('#<%=rblVisitType.ClientID%> input[type=radio]:checked').Text;
                    // alert($('#<%=rblVisitType.ClientID %> input[type=radio]:checked').Text());
                    var PaymentReceiptNo = document.getElementById('txtcashPhysicalReceiptNo').value;
                    var Amount = parseFloat(document.getElementById('txtCashAmount').value);
                    var ManualRemarks = document.getElementById('txtCashRemarks').value;
                    var Remarks = "ResponseCode: 0, ResponseMsg: Cash Deposited, TxnId: " + PaymentReceiptNo;
                    var Cashdatetemp = document.getElementById('txtCashDate').value;
                    var chunks = Cashdatetemp.split('/');
                    var Cashdate = chunks[1] + '/' + chunks[0] + '/' + chunks[2];
                    var lstClientReceipt = [];
                    lstClientReceipt.push({
                        OrgID: OrgID,
                        SourceCode: SourceCode,
                        Mode: 'Offline',
                        PaymentType: 'Cash',
                        PaymentReceiptNo: PaymentReceiptNo,
                        Amount: Amount,
                        ResponseCode: '1',
                        Remarks: Remarks,
                        ManualRemarks: ManualRemarks,
                        CreatedBy: CreatedBy,
                        ReceiptDate: Cashdate
                    });
                    var ClientReceipt = JSON.stringify(lstClientReceipt);
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/SaveInvoiceOfflineReceipt",
                        contentType: "application/json;charset=utf-8",
                        data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "','Orgid':'" + OrgID + "'}",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var succescode = data.d;

                            if (succescode > 0) {
                                alert('Receipt Sumitted Successfully!');
                                //Reset();
                                // window.location = "http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/InvoicePayment.aspx";
                                window.location = "http://appvm1.cloudapp.net/Lims_Product/Ledger/InvoicePayment.aspx";


                            }
                            else {
                                alert('Error Exist!');
                                Reset();
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            return false;
                        }
                    });
                }

            }
            else if (UsedPaymentType == 'INVOICEWISE') {
                if (document.getElementById('rblVisitType_1').checked == true || document.getElementById('rblVisitType_2').checked == true || document.getElementById('rblVisitType_3').checked == true) {
                    var Paymenttype;
                    if (document.getElementById('rblVisitType_1').checked == true) {
                        Paymenttype = 'Cheque';
                    }
                    /* Selva Start  */
                    else if (document.getElementById('rblVisitType_2').checked == true) {
                        Paymenttype = 'DD';
                    }
                    else if (document.getElementById('rblVisitType_3').checked == true) {
                        Paymenttype = 'Bank Deposit';
                    }
                    /* Selva End  */
                    var PaymentReceiptNo = document.getElementById('txtChequePhysicalReceiptNo').value;
                    var BankName = document.getElementById('txtBankName').value;
                    var ChequeNumber = document.getElementById('txtChequeNumber').value;
                    var Amount = parseFloat(document.getElementById('txtChequeAmount').value);
                    var Remarks = "ResponseCode: 0, ResponseMsg: " + Paymenttype + " Deposited, TxnId: " + PaymentReceiptNo;
                    var ManualRemarks = document.getElementById('txtChequeRemarks').value;
                    var filenamepath = SourceCode + "_" + PaymentReceiptNo + "_" + FiName; //get clientcode,receipt no and filname
                    var Address = FolderName + filenamepath; //'F:|ReceiptEntryImages|' + filenamepath; ////FolderName + 
                    var Chequedatetemp = document.getElementById('txtChequedate').value;
                    var chunks = Chequedatetemp.split('/');
                    var Chequedate = chunks[1] + '/' + chunks[0] + '/' + chunks[2];

                    var lstClientReceipt = [];
                    lstClientReceipt.push({
                        OrgID: OrgID,
                        SourceCode: SourceCode,
                        BankName: BankName,
                        ChequeNo: ChequeNumber,
                        Mode: 'Offline',
                        PaymentType: Paymenttype,
                        PaymentReceiptNo: PaymentReceiptNo,
                        Amount: Amount,
                        ResponseCode: '1',
                        Remarks: Remarks,
                        ManualRemarks: ManualRemarks,
                        CreatedBy: CreatedBy,
                        ReceiptDate: Chequedate
                    });
                    var ClientReceipt = JSON.stringify(lstClientReceipt);
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/SaveMultipleInvoiceOfflineReceipt",
                        contentType: "application/json;charset=utf-8",
                        data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "','Orgid':'" + OrgID + "','UsedPaymentType':'" + UsedPaymentType + "'}",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var succescode = data.d;
                            //                            if (succescode == -1) {
                            //                                //imagesave().kill;
                            //                                alert('Please Enter the Correct PaymentReceiptNo');
                            //                                Reset();
                            //                            }
                            //                            if (succescode == -2) {
                            //                                alert('Please Enter the Correct ChequeNo');
                            //                                Reset();
                            //                            }
                            if (succescode > 0) {
                                imagesave(succescode);
                                alert('Receipt Sumitted Successfully!');
                                Reset();
                                // window.location = "http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/InvoicePayment.aspx";
                                window.location = "http://appvm1.cloudapp.net/Lims_Product/Ledger/InvoicePayment.aspx";


                            }
                            else {
                                alert('Error Exist!');
                                Reset();
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            debugger;
                            alert("Error");
                            return false;
                        }
                    });
                }
                else {
                    //var PaymentType = $('#<%=rblVisitType.ClientID%> input[type=radio]:checked').Text;
                    // alert($('#<%=rblVisitType.ClientID %> input[type=radio]:checked').Text());
                    var PaymentReceiptNo = document.getElementById('txtcashPhysicalReceiptNo').value;
                    var Amount = parseFloat(document.getElementById('txtCashAmount').value);
                    var ManualRemarks = document.getElementById('txtCashRemarks').value;
                    var Remarks = "ResponseCode: 0, ResponseMsg: Cash Deposited, TxnId: " + PaymentReceiptNo;
                    var Cashdatetemp = document.getElementById('txtCashDate').value;
                    var chunks = Cashdatetemp.split('/');
                    var Cashdate = chunks[1] + '/' + chunks[0] + '/' + chunks[2];
                    var lstClientReceipt = [];
                    lstClientReceipt.push({
                        OrgID: OrgID,
                        SourceCode: SourceCode,
                        Mode: 'Offline',
                        PaymentType: 'Cash',
                        PaymentReceiptNo: PaymentReceiptNo,
                        Amount: Amount,
                        ResponseCode: '1',
                        Remarks: Remarks,
                        ManualRemarks: ManualRemarks,
                        CreatedBy: CreatedBy,
                        ReceiptDate: Cashdate
                    });
                    var ClientReceipt = JSON.stringify(lstClientReceipt);
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/SaveMultipleInvoiceOfflineReceipt",
                        contentType: "application/json;charset=utf-8",
                        data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "','Orgid':'" + OrgID + "','UsedPaymentType':'" + UsedPaymentType + "'}",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var succescode = data.d;

                            if (succescode > 0) {
                                alert('Receipt Sumitted Successfully!');
                                //Reset();http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/Ledger/InvoicePayment.aspx"
                                window.location = "http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/Ledger/InvoicePayment.aspx";

                            }
                            else {
                                alert('Error Exist!');
                                Reset();
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            debugger;
                            alert("Error");
                            return false;
                        }
                    });
                }


            }

            return true;
        }


        function Select(id) {
            debugger;
            var BillingAmount = parseFloat(document.getElementById('txtAmount').value);
            var AdvanceAmount = parseFloat(document.getElementById('txtAdvanceAmount').value);
            var UsedAdvanceAmount = '0';
            var IsUsed = 'N';
            if (document.getElementById('chkAdvanceSelect').checked == true) {
                if (AdvanceAmount >= BillingAmount) {
                    document.getElementById('txtPayAmount').value = "0";
                    var vallbl = parseFloat(document.getElementById('txtAdvanceAmount').value) - parseFloat(document.getElementById('txtAmount').value);
                    document.getElementById('lblBalanceAdvance').innerHTML = vallbl.toFixed(3);
                    document.getElementById("trReminingAdv").style.display = 'block';
                    document.getElementById('btnProceed').style.display = 'block';
                    document.getElementById('DivRpwd').style.display = 'none';
                    document.getElementById('DivCheque').style.display = 'none';
                    document.getElementById('DivCash').style.display = 'none';
                    //                    UsedAdvanceAmount = vallbl.toFixed(3);
                    //                    IsUsed = 'Y';
                    //                    CreatedSession(UsedAdvanceAmount, IsUsed)

                }
                else if (BillingAmount > AdvanceAmount) {
                    var val = parseFloat(document.getElementById('txtAmount').value) - parseFloat(document.getElementById('txtAdvanceAmount').value);
                    document.getElementById('txtPayAmount').value = val.toFixed(3);
                    document.getElementById('lblBalanceAdvance').innerHTML = "0";
                    document.getElementById("trReminingAdv").style.display = 'block';
                    document.getElementById("lblBalanceAdvance").style.display = 'block';
                    document.getElementById('btnProceed').style.display = 'none';
                    document.getElementById('txtCashAmount').value = document.getElementById('txtPayAmount').value;
                    document.getElementById('rblVisitType_0').checked = true
                    document.getElementById('rblVisitType_1').style.visibility = "hidden";
                    document.getElementById('rblVisitType_1').nextSibling.style.visibility = "hidden";
                    document.getElementById('rblVisitType_2').style.visibility = "hidden";
                    document.getElementById('rblVisitType_2').nextSibling.style.visibility = "hidden";
                    document.getElementById('rblVisitType_3').style.visibility = "hidden";
                    document.getElementById('rblVisitType_3').nextSibling.style.visibility = "hidden";
                    document.getElementById('btnCashSubmit').style.display = 'none';
                    document.getElementById('btnCashAdvence').style.display = 'block';
                    document.getElementById('DivRpwd').style.display = 'block';
                    document.getElementById('DivCheque').style.display = 'none';
                    document.getElementById('DivCash').style.display = 'block';

                    UsedAdvanceAmount = AdvanceAmount.toFixed(3);
                    IsUsed = 'Y';
                    // CreatedSession(UsedAdvanceAmount, IsUsed);

                }

            }
            else if (document.getElementById('chkAdvanceSelect').checked == false) {

                document.getElementById('txtPayAmount').value = document.getElementById('txtAmount').value;
                document.getElementById("trReminingAdv").style.display = 'none';
                document.getElementById('btnProceed').style.display = 'none';
                document.getElementById('DivRpwd').style.display = 'block';
                document.getElementById('DivCash').style.display = 'block';
                document.getElementById('lblBalanceAdvance').style.display = 'none';
                document.getElementById('rblVisitType_1').style.display = 'block';
                document.getElementById('rblVisitType_2').style.display = 'block';
                document.getElementById('rblVisitType_3').style.display = 'block';
                document.getElementById('txtCashAmount').value = document.getElementById('txtAmount').value;
                document.getElementById('rblVisitType_1').style.visibility = "";
                document.getElementById('rblVisitType_1').nextSibling.style.visibility = "";
                document.getElementById('rblVisitType_2').style.visibility = "";
                document.getElementById('rblVisitType_2').nextSibling.style.visibility = "";
                document.getElementById('rblVisitType_3').style.visibility = "";
                document.getElementById('rblVisitType_3').nextSibling.style.visibility = "";
                document.getElementById('btnCashSubmit').style.display = 'block';
                document.getElementById('btnCashAdvence').style.display = 'none';
            }

        }

        function CreatedSession(AdvanceAmount, IsUsed) {

            debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/CreateAdvanceSession",
                contentType: "application/json;charset=utf-8",
                data: "{AdvanceAmount:'" + AdvanceAmount + "','IsUsed':'" + IsUsed + "'}",
                dataType: "json",
                async: false,
                success: function(data) {
                    var succescode = data.d;

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    debugger;
                    alert("Error");
                    return false;
                }
            });
        }

        function Reload() {
            alert('Receipt Sumitted Successfully!');
            //Reset();http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/InvoicePayment.aspx
            window.location = "http://attune-cs-lis.cloudapp.net:8081/Kernel_Prepod/Ledger/InvoicePayment.aspx";
        }
    </script>

</body>
</html>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<script language="javascript" type="text/javascript">

    function pageLoad() {
        $("#txtChequedate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback
        $("#txtCashDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });


    }
    function popupClose() {
        return true;
    }
    $(function() {
        $("#txtChequedate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });
        $("#txtCashDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });



    }); 
                      
</script>

