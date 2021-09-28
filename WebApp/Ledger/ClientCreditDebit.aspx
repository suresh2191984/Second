<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientCreditDebit.aspx.cs"
    Inherits="Ledger_ClientCreditDebit" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Client Credit/Debit</title>
    <style type="text/css">
        .schedule_title
        {
            width: 452px;
            color: #fff;
            font-weight: bold;
            background: #3D667F;
            margin: 50px auto 0 auto;
            height: 15px;
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
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="pendingProgress" style="display: none;">
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </div>
    <div class="contentdata">
        <%--<asp:UpdatePanel ID="UdtPanel" runat="server">
            <ContentTemplate>--%>
        <div align="center" id="Divtype">
            <table>
                <tr>
                    <td class="a-Right w-30p" nowrap="nowrap">
                        <asp:Label ID="lblEntrytype" runat="server" Text="Type"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left w-20 p">
                        <asp:DropDownList ID="ddlEntrytype" AutoPostBack="true" runat="server" CssClass="small"
                            onchange="enableEntry()" OnSelectedIndexChanged="ddlEntrytype_SelectedIndexChanged">
                            <asp:ListItem Value="C" Text="Credit/Debit Entry" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="R" Text="Receipt Entry"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div class="schedule_title" id="DivCredit">
            CREDIT/DEBIT JOURNAL ENTRY PAGE
        </div>
        <div class="scheduledataheader2 a-center" id="DivLpwd" runat="server">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-left w-28p" nowrap="nowrap">
                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblopResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left w-25p">
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="small">
                            <asp:ListItem Value="" Text="TSP"> </asp:ListItem>
                            <asp:ListItem Value="" Text="DSA"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left" height="35" nowrap="nowrap">
                        <asp:Label ID="lblType" runat="server" Text="Type" meta:resourcekey="lblnpResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:DropDownList ID="ddlType" runat="server" CssClass="small" onchange="Javascript:return GetNattation();">
                            <asp:ListItem Value="C" Text="CREDIT" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="D" Text="DEBIT"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="a-left w-35p" nowrap="nowrap">
                        <asp:Label ID="lblTSPCode" runat="server" Text="Select The TSP Code" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:HiddenField ID="hdnClientID" runat="server" />
                        <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                            OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                            OnClientItemOver="SelectedOver" Enabled="True">
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
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblNarration" runat="server" Text="Narration" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:DropDownList ID="ddlNarration" runat="server" CssClass="medium">
                        </asp:DropDownList>
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
                        <asp:Label ID="lblEnterBarCode" runat="server" Text="  Enter Bar Code" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtEnterBarCode" Width="78%" MaxLength="8" onkeypress="return NumbersOnly(event);"
                            runat="server"></asp:TextBox>
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
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblReEnterBarCode" runat="server" Text="ReEnter Bar Code" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtReEnterBarCode" Width="78%" onkeypress="return NumbersOnly(event);"
                            MaxLength="8" runat="server"></asp:TextBox>
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
                        <asp:Label ID="lblEnterAmount" runat="server" Text="Enter Amount" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtEnterAmount" Width="78%" runat="server" TabIndex="5" MaxLength="8"
                            onblur="validateCash('txtEnterAmount')" onkeypress="return NumbersOnly(event);"></asp:TextBox>
                        <%-- onkeydown="return validatenumber(event)"   onkeypress="return NumbersOnly(event);"--%>
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
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblReEnterAmount" runat="server" Text="ReEnter Amount" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtReEnterAmount" Width="78%" runat="server" TabIndex="5" MaxLength="8"
                            onkeypress="return NumbersOnly(event);"></asp:TextBox>
                        <%--onkeydown="return validatenumber(event)" onkeypress="return NumbersOnly(event);"--%>
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
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblRemarks" runat="server" Text="Remarks" meta:resourcekey="lblcpdResource2"></asp:Label>
                        <%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtRemarks" TabIndex="6" runat="server" TextMode="MultiLine" MaxLength="200"
                            Width="160px" onKeyUp="Count(this,200)" onChange="Count(this,200)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFname" runat="server" ControlToValidate="txtRemarks"
                            Display="None" ErrorMessage="Please Enter Comments!" SetFocusOnError="true" ValidationGroup="reject"
                            ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="regex1txtComments" ValidationGroup="reject"
                            Display="None" ControlToValidate="txtRemarks" ValidationExpression="(\s|.){0,200}$"
                            ErrorMessage="Comments Maximum Length should be 200!" Text="" ForeColor="Red" />
                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ValidationGroup="FindAddressApprove"
                            Display="None" ControlToValidate="txtRemarks" ValidationExpression="(\s|.){0,200}$"
                            SetFocusOnError="true" ErrorMessage="Comments Maximum Length should be 200!"
                            ForeColor="Red" Text="" />
                        <%--<asp:TextBox ID="txtRemarks"  runat="server" Columns="30" TextMode="MultiLine"
                                    TabIndex="5"></asp:TextBox>--%>
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
                    <td class="emptyrow">
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return validate();"
                            TabIndex="4" Text="Submit" CssClass="btn" meta:resourcekey="btnChangeResource2" />
                        &nbsp;
                        <asp:Button ID="btnReset" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                            meta:resourcekey="btnChangeResource2" OnClientClick="javascript:return Reset();" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="schedule_title" id="DivReciept" class="hidden_div" style="display: none;">
            RECIEPT ENTRY PAGE
        </div>
        <div class="scheduledataheader2 a-center" id="DivRpwd" runat="server" style="display: none;">
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
        <div class="scheduledataheader2 a-center" id="DivCheque" runat="server" style="display: none;">
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
                <%--<tr>
                    <td class=" a-left">
                        <asp:Label ID="lblChequedate" Text="Date:" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:TextBox Width="70px" size="25" ID="txtChequedate" CssClass="Txtboxsmall" runat="server"
                            meta:resourcekey="txtFromResource1"></asp:TextBox>
                    </td>
                </tr>--%>
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
                        <asp:TextBox ID="txtChequeAmount" Width="78%" runat="server" MaxLength="8" onblur="validateCash('txtChequeAmount')"
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
                        <%--<img align="middle" alt="" src="../Images/starbutton.png" />--%>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="txtChequeRemarks" runat="server" TextMode="MultiLine" MaxLength="200"
                            Width="160px" onKeyUp="Count(this,200)" onChange="Count(this,200)"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;<br />
                    </td>
                </tr>
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
                            CssClass="btn" />
                        &nbsp;
                        <asp:Button ID="btnChequeReset" runat="server" Text="Reset" CssClass="btn" OnClientClick="javascript:return Reset();" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="scheduledataheader2 a-center" id="DivCash" runat="server" style="display: none;">
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
                        <asp:TextBox ID="txtCashAmount" Width="78%" MaxLength="8" runat="server" onblur="validateCash('txtCashAmount')"
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
                        <%-- <img align="middle" alt="" src="../Images/starbutton.png" />--%>
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
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Button ID="btnCashSubmit" runat="server" Text="Submit" OnClientClick="javascript:return Cashvalidate()"
                            CssClass="btn" />
                        &nbsp;
                        <asp:Button ID="btnCashReset" runat="server" Text="Reset" CssClass="btn" OnClientClick="javascript:return Reset();" />
                    </td>
                </tr>
            </table>
        </div>
        <%--</ContentTemplate> </asp:UpdatePanel>--%>
    </div>
    <asp:HiddenField ID="hdnBarcodeNumber" runat="server" />
    <asp:HiddenField ID="hdnClientLoginID" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnDrivePath" runat="server" />
    <%--  <asp:HiddenField ID="handlerpath" runat="server" /> value="F:\\ReceiptEntryImages\\"  --%>
    <asp:HiddenField ID="FileName" runat="server" />
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function validate() {

            if (document.getElementById("<%=txtClientName.ClientID%>").value == "" || document.getElementById("<%=txtClientName.ClientID%>").value == "0") {
                alert("Select the TSP Code");
                document.getElementById("<%=txtClientName.ClientID%>").focus();
                return false;
            }

            if (document.getElementById("<%=ddlNarration.ClientID%>").value == "" || document.getElementById("<%=ddlNarration.ClientID%>").value == "0") {
                alert("Select the Narration");
                document.getElementById("<%=ddlNarration.ClientID%>").focus();
                return false;
            }
            if (document.getElementById("<%=txtEnterBarCode.ClientID%>").value == "") {
                //                alert("Enter the Barcode Number");
                //                document.getElementById("<%=txtEnterBarCode.ClientID%>").focus();
                //                document.getElementById("<%=txtEnterBarCode.ClientID%>").value = "";
                //                return false;
            }
            else if (document.getElementById("<%=txtEnterBarCode.ClientID%>").value.length != 8) {
                alert("Barcode Should Be Minimum 8 Digit");
                document.getElementById("<%=txtEnterBarCode.ClientID%>").focus();
                document.getElementById("<%=txtEnterBarCode.ClientID%>").value = "";
                return false;
            }
            if (document.getElementById("<%=txtReEnterBarCode.ClientID%>").value == "") {
                //                alert("Enter the ReEnter Barcode Number");
                //                document.getElementById("<%=txtReEnterBarCode.ClientID%>").focus();
                //                document.getElementById("<%=txtReEnterBarCode.ClientID%>").value = "";
                //                return false;
            }
            else if (document.getElementById("<%=txtReEnterBarCode.ClientID%>").value.length != 8) {
                alert("ReEnter Barcode Should Be Minimum 8 Digit");
                document.getElementById("<%=txtReEnterBarCode.ClientID%>").focus();
                document.getElementById("<%=txtReEnterBarCode.ClientID%>").value = "";
                return false;
            }


            var enteredBarcode = document.getElementById("<%=txtEnterBarCode.ClientID%>").value;
            var ReEnteredBarcode = document.getElementById("<%=txtReEnterBarCode.ClientID%>").value;

            if (enteredBarcode != ReEnteredBarcode) {
                alert("Barcode and ReEnter Barcode  not matched");
                document.getElementById("<%=txtReEnterAmount.ClientID%>").focus();
                document.getElementById("<%=txtReEnterBarCode.ClientID%>").value = "";
                return false;
            }


            if (document.getElementById("<%=txtEnterAmount.ClientID%>").value == "") {
                alert("Enter the Amount");
                document.getElementById("<%=txtEnterAmount.ClientID%>").focus();
                return false;
            }


            if (document.getElementById("<%=txtReEnterAmount.ClientID%>").value == "") {
                alert("ReEnter the Amount");
                document.getElementById("<%=txtReEnterAmount.ClientID%>").focus();
                return false;
            }

            var enteredAmount = document.getElementById("<%=txtEnterAmount.ClientID%>").value;
            var ReEnteredAmount = document.getElementById("<%=txtReEnterAmount.ClientID%>").value;

            if (enteredAmount != ReEnteredAmount) {
                alert("Amount not matched");
                document.getElementById("<%=txtReEnterAmount.ClientID%>").focus();
                return false;
            }

            var enteredAmount = document.getElementById("<%=txtEnterAmount.ClientID%>").value;
            var ReEnteredAmount = document.getElementById("<%=txtReEnterAmount.ClientID%>").value;

            if (enteredAmount != ReEnteredAmount) {
                alert("Amount not matched");
                document.getElementById("<%=txtReEnterAmount.ClientID%>").focus();
                return false;
            }


            //            if (document.getElementById("<%=txtRemarks.ClientID%>").value == "") {
            //                alert("Remarks should not be empty");
            //                document.getElementById("<%=txtRemarks.ClientID%>").focus();
            //                return false;
            //            }
            savedata();
            return true;
        }
        $(document).ready(function() {
            $('#txtReEnterBarCode').bind('copy paste cut', function(e) {
                e.preventDefault();
            });
        });


        $(document).ready(function() {
            $('#txtReEnterAmount').bind('copy paste cut', function(e) {
                e.preventDefault();
            });
        });

        function SelectedOver(source, eventArgs) {
            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtClientName').value = '';
                    document.getElementById('<%=hdnClientID.ClientID %>').value = '';
                }
            };
        }
        function SetClientID(source, eventArgs) {
            // alert(eventArgs.get_value());
            var list = eventArgs.get_value().split('^');
            document.getElementById('<%=hdnClientID.ClientID %>').value = list[3];

        }

        function SetBarcode() {

            if (document.getElementById('txtEnterBarCode').value != "") {

                document.getElementById('hdnBarcodeNumber').value = document.getElementById('txtEnterBarCode').value;
            }

        }

        function Count(text, long) {
            var maxlength = new Number(long); // Change number to your max length.
            if (text.value.length > maxlength) {
                text.value = text.value.substring(0, maxlength);
                alert(" Only " + long + " characters allowed.");
            }
        }

        $(document).ready(function() {
            $("#DivReciept").hide();
            $("#DivCheque").hide();
            $("#DivRpwd").hide();
            $("#DivCash").hide();

        });
 
    </script>

    <script language="javascript" type="text/javascript">
        function NumbersOnly(e) {
            var charCode = e.charCode ? e.charCode : e.keyCode

            //  var testValue = document.getElementById('txtCashAmount').value;

            if (charCode != 8 && charCode != 9 && charCode != 46) {
                if (charCode < 48 || charCode > 57)
                    return false;
            }

        }
    </script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            GetNattation();
            enableEntry();

        });
        function savedata() {
            debugger;
            var OrgID = parseInt(document.getElementById('hdnOrgID').value);
            var SourceCode = document.getElementById('hdnClientID').value;
            var BarCode = document.getElementById('txtEnterBarCode').value;
            var Amount = parseFloat(document.getElementById('txtEnterAmount').value);
            var Remarks = document.getElementById('txtRemarks').value;
            var CreatedBy = document.getElementById('hdnClientLoginID').value;
            var CreatedAt = document.getElementById('hdnDate').value;
            var lstClientCredit = [];
            var lstClientDebit = [];
            var e = document.getElementById("ddlCategory");
            var Category = e.options[e.selectedIndex].text;
            var ddlID = $get('ddlNarration');
            var ddlSelect = ddlID.options[ddlID.selectedIndex];
            var Narration = ddlSelect.text;
            var TypeId = document.getElementById("ddlType");
            var Type = TypeId.options[TypeId.selectedIndex].text;
            if (Type == 'CREDIT') {
                lstClientCredit.push({
                    OrgID: OrgID,
                    Category: Category,
                    SourceCode: SourceCode,
                    Narration: Narration,
                    BarCode: BarCode,
                    Amount: Amount,
                    Remarks: Remarks,
                    CreatedBy: CreatedBy
                });
                var ClientCredit = JSON.stringify(lstClientCredit);
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SaveClientCredit",
                    contentType: "application/json;charset=utf-8",
                    data: "{lstClientCredit:'" + ClientCredit + "'}",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        debugger;
                        var succescode = data.d;
                        if (succescode > 0) {
                            alert('Credit Sumitted Successfully!');
                            Reset();
                        }
                        else {
                            alert('Same Narration for the Client Already Exist!');
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
            if (Type == 'DEBIT') {
                lstClientDebit.push({
                    OrgID: OrgID,
                    Category: Category,
                    SourceCode: SourceCode,
                    Narration: Narration,
                    BarCode: BarCode,
                    Amount: Amount,
                    Remarks: Remarks,
                    CreatedBy: CreatedBy
                });
                var ClientDebit = JSON.stringify(lstClientDebit);
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SaveClientDebit",
                    contentType: "application/json;charset=utf-8",
                    data: "{lstClientDebit:'" + ClientDebit + "'}",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var succescode = data.d;
                        if (succescode > 0) {
                            alert('Debit Sumitted Successfully!');
                            Reset();
                        }
                        else {
                            alert('Same Narration for the Client Already Exist!');
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
            return true;
        }

        function ClearData() {
            document.getElementById('txtEnterBarCode').value = "";
            document.getElementById('txtReEnterBarCode').value = "";
            document.getElementById('txtEnterAmount').value = "";
            document.getElementById('txtReEnterAmount').value = "";
            document.getElementById('txtRemarks').value = "";
        }

        function GetNattation() {
            ClearData();
            var TypeId = document.getElementById("ddlType");
            var Type = TypeId.options[TypeId.selectedIndex].value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetCreditDebitNarrationList",
                contentType: "application/json;charset=utf-8",
                data: "{'Type':'" + Type + "'}",
                dataType: "json",
                async: false,
                success: function(response) {
                    $("select[id$=ddlNarration] > option").remove();
                    var models = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    var ddl = $('#ddlNarration');
                    ddl.append("<option value='0'>Select Narration Type</option>");
                    for (var i = 0; i < models.length; i++) {
                        var val = models[i].Narration;
                        var text = models[i].Id;
                        ddl.append("<option value='" + text + "'>" + val + "</option>");
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    debugger;
                    alert("Error");
                    return false;
                }
            });
            return false;
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
            window.location.href = "../Ledger/ClientCreditDebit.aspx";
            return false;
        }
    </script>

    <script language="javascript" type="text/javascript">
        function enableEntry() {
            if (document.getElementById('ddlEntrytype').value == "R") {
                document.getElementById("DivRpwd").style.display = 'block';
                document.getElementById("DivReciept").style.display = 'block';
                document.getElementById("DivCredit").style.display = 'none';
                document.getElementById("DivLpwd").style.display = 'none';
                document.getElementById('rblVisitType_0').checked = true;
                document.getElementById("DivCash").style.display = 'block';
            }
            else {
                document.getElementById("DivRpwd").style.display = 'none';
                document.getElementById("DivCash").style.display = 'none';
                document.getElementById("DivCheque").style.display = 'none';
                document.getElementById("DivReciept").style.display = 'none';
                document.getElementById("DivCredit").style.display = 'block';
                document.getElementById("DivLpwd").style.display = 'block';

            }

        }
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

            if (document.getElementById("<%=txtCashReAmount.ClientID%>").value == "") {
                alert("Enter the ReEnter Amount");
                document.getElementById("<%=txtCashReAmount.ClientID%>").focus();
                return false;
            }


            //            if (document.getElementById("<%=txtCashRemarks.ClientID%>").value == "") {
            //                alert("Remarks should not be empty");
            //                document.getElementById("<%=txtCashRemarks.ClientID%>").focus();
            //                return false;
            //            }

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

            if (document.getElementById("<%=txtChequeEnterAmount.ClientID%>").value == "") {
                alert("Enter the ReEnter Amount");
                document.getElementById("<%=txtChequeEnterAmount.ClientID%>").focus();
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


            //            if (document.getElementById("<%=txtChequeRemarks.ClientID%>").value == "") {
            //                alert("Remarks should not be empty");
            //                document.getElementById("<%=txtChequeRemarks.ClientID%>").focus();
            //                return false;
            //            }

            if (document.getElementById("<%=fpProofCopy.ClientID%>").value == "") {
                alert("Please Select file name");
                document.getElementById("<%=fpProofCopy.ClientID%>").focus();
                return false;
            }

            SaveReceipt();
            return true;
        }

        function validateCash(val) {

            if (val = 'txtEnterAmount') {
                var enteredAmount = document.getElementById("<%=txtEnterAmount.ClientID%>").value;
            }
            else if (val = 'txtChequeAmount') {
                var enteredAmount = document.getElementById("<%=txtChequeAmount.ClientID%>").value;

            }
            else if (val = 'txtCashAmount') {
                var enteredAmount = document.getElementById("<%=txtCashAmount.ClientID%>").value;
            }

            var re = /^\d+(?:\.\d{1,3})?$/;
            if (re.test(enteredAmount)) {
                return true;
            }
            else {
                alert('Please Enter valid amount');
                if (val = 'txtEnterAmount') {
                    document.getElementById("<%=txtEnterAmount.ClientID%>").value = '';
                }
                else if (val = 'txtChequeAmount') {
                    document.getElementById("<%=txtChequeAmount.ClientID%>").value = '';

                }
                else if (val = 'txtCashAmount') {
                    document.getElementById("<%=txtCashAmount.ClientID%>").value = '';
                }

                //document.getElementById("<%=txtCashAmount.ClientID%>").focus();
                return false;
            }
        }
    </script>

    <script language="javascript" type="text/javascript">

        function imagesave() {
            debugger;

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
                url: "AjaxFileHandler.ashx?fname=" + FolderName + "&SCRN=" + SourceCode + "_" + PaymentReceiptNo + "_",
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
                    alert('Photocopy Uploaded successfully');
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
                debugger;
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
                    //ReceiptDate: Chequedate,

                    //UploadedImages: 
                    //Address + fileName


                    //var filename = $('#image_file').val();
                });
                var ClientReceipt = JSON.stringify(lstClientReceipt);
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SaveClientReceipt",
                    contentType: "application/json;charset=utf-8",
                    data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "'}",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        debugger;
                        var succescode = data.d;
                        if (succescode == -1) {
                            //imagesave().kill;
                            alert('Please Enter the Correct PaymentReceiptNo')
                            Reset();
                        }
                        if (succescode == -2) {
                            alert('Please Enter the Correct ChequeNo')
                            Reset();
                        }
                        if (succescode > 0) {
                            imagesave();
                            alert('Receipt Sumitted Successfully!');
                            Reset();

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
                    url: "../WebService.asmx/SaveClientReceipt",
                    contentType: "application/json;charset=utf-8",
                    data: "{lstClientReceipt:'" + ClientReceipt + "','Address':'" + Address + "'}",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        debugger;
                        var succescode = data.d;
                        if (succescode > 0) {
                            alert('Receipt Sumitted Successfully!');
                            Reset();
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
            return true;
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

