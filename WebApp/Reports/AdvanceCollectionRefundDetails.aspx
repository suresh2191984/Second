<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="AdvanceCollectionRefundDetails.aspx.cs"
    Inherits="Reports_AdvanceCollectionRefundDetails" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Advance CollectionRefund Details</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .dataheader3
        {
            margin-right: 2px;
        }
        .displayFalse
        {
            display: none;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript" language="javascript">
        /*
        function SetClientID(source, eventArgs) {
        document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
        }
        */
        function validatenumber(evt) {
            var keyCode = 0;
            if (evt) {
                keyCode = evt.keyCode || evt.which;
            }
            else {
                keyCode = window.event.keyCode;
            }
            //alert('keyCode  : '+keyCode);
            if ((keyCode >= 48 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105) || (keyCode == 108) || (keyCode == 119) || (keyCode == 110) || (keyCode == 32) || (keyCode == 111) || (keyCode == 118) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) || (keyCode == 27) || (keyCode == 37) || (keyCode == 39) || (keyCode == 46) || (keyCode == 190) || (keyCode == 188)) {
                return true;
            }
            else {
                return false;
            }
        }

        function checkForValues1() {

            if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                alert('Provide correct page number');
                return false;
            }
        }
        function OnselectedClientName(source, eventArgs) {
            document.getElementById('<%=txtClientNameSrch.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
            document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
            document.getElementById('<%=hdnClientTypeID.ClientID %>').value = '0';
        }
        function ClearData() {

            document.getElementById('<%=txtClientNameSrch.ClientID %>').value = "";
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
            document.getElementById('<%=ddlType.ClientID %>').selectedIndex = 0;

            var grdResult = document.getElementById('<%=grdResult.ClientID %>');
            if (grdResult !== null) {
                document.getElementById('<%=grdResult.ClientID %>').outerHTML = "";
            }
            var gridRefund = document.getElementById('<%=gridRefund.ClientID %>');
            if (gridRefund !== null) {
                document.getElementById('<%=gridRefund.ClientID %>').outerHTML = "";
            }
            var PrintgrdResult = document.getElementById('<%=PrintgrdResult.ClientID %>');
            if (PrintgrdResult !== null) {
                document.getElementById('<%=PrintgrdResult.ClientID %>').outerHTML = "";
            }
            var PrintgridRefund = document.getElementById('<%=PrintgridRefund.ClientID %>');
            if (PrintgridRefund !== null) {
                document.getElementById('<%=PrintgridRefund.ClientID %>').outerHTML = "";
            }
            return true;
        }
        function popupprint() {

            var grdResult = document.getElementById('<%=grdResult.ClientID %>');

            var gridRefund = document.getElementById('<%=gridRefund.ClientID %>');

            var PrintgrdResult = document.getElementById('<%=PrintgrdResult.ClientID %>');

            var PrintgridRefund = document.getElementById('<%=PrintgridRefund.ClientID %>');

            if (grdResult === null && gridRefund === null && PrintgrdResult === null && PrintgridRefund === null) {
                alert('No Records Found');
                return false;
            }
            else {
                var prtContent = document.getElementById('<%=printCashClosure.ClientID %>');
                var WinPrint = window.open('', '', 'letf=100,top=100,height=600,width=1050,toolbar=0,scrollbars=1,status=0,resizable=1');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                return false;
            }
        }

        function checkDate1(obj) {
            var obj = document.getElementById('<%=txtFromDate.ClientID %>');
            if (obj.value != '') {
                var DOB = obj.value.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = new Date();
                var curday = dateObj.getDate();
                var curmon = dateObj.getMonth() + 1;
                var curyear = dateObj.getFullYear();

                if (parseFloat(calyear) > parseFloat(curyear)) {
                    $("#" + obj.id).val("");
                    alert("Enter year should not be greater than current year");
                    return false;
                }
                else {
                    if (parseFloat(calmon) > parseFloat(curmon)) {
                        $("#" + obj.id).val("");
                        alert("Enter month should not be greater than current month");
                        return false;
                    }
                    else {

                        if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                            $("#" + obj.id).val("");
                            alert("Enter date should not be greater than current Date");
                            return false;
                        }
                        else {
                            return true;
                        }
                    }
                }
            }
        }
        function checkDate2(obj) {
            var obj = document.getElementById('<%=txtToDate.ClientID %>');
            if (obj.value != '') {
                var DOB = obj.value.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = new Date();
                var curday = dateObj.getDate();
                var curmon = dateObj.getMonth() + 1;
                var curyear = dateObj.getFullYear();

                if (parseFloat(calyear) > parseFloat(curyear)) {
                    $("#" + obj.id).val("");
                    alert("Enter year should not be greater than current year");
                    return false;
                }
                else {
                    if (parseFloat(calmon) > parseFloat(curmon)) {
                        $("#" + obj.id).val("");
                        alert("Enter month should not be greater than current month");
                        return false;
                    }
                    else {

                        if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                            $("#" + obj.id).val("");
                            alert("Enter date should not be greater than current Date");
                            return false;
                        }
                        else {
                            return true;
                        }
                    }
                }
            }
        }
        function ClearClientValues() {
            // debugger;
            if (document.getElementById('<%=txtClientNameSrch.ClientID %>').value == "") {
                document.getElementById('<%=hdnClientID.ClientID %>').value = "";
            }
        }
        function Validate() {

            var txt = document.getElementById('<%=txtClientNameSrch.ClientID %>').value;
            var fdate = document.getElementById('<%=txtFromDate.ClientID %>').value;
            var tdate = document.getElementById('<%=txtToDate.ClientID %>').value;
            if (fdate.length === 0 || tdate.length === 0) {
                alert('From Date and To Date are mandatory');
                return false;
            }
            else {
                var DOB = fdate.split('/');
                var calday = DOB[0];
                var calmon = DOB[1];
                var calyear = DOB[2];

                var dateObj = tdate.split('/'); ;
                var curday = dateObj[0];
                var curmon = dateObj[1];
                var curyear = dateObj[2];

                if (parseFloat(calyear) > parseFloat(curyear)) {
                    alert("FromDate year should not be greater than ToDate year");
                    return false;
                }
                else {
                    if (parseFloat(calmon) > parseFloat(curmon)) {
                        alert("FromDate month should not be greater than ToDate month");
                        return false;
                    }
                    else {

                        if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
                            alert("FromDate date should not be greater than ToDate Date");
                            return false;
                        }
                        else {
                            if (txt.length === 0) {
                                document.getElementById('<%=hdnFromDate.ClientID %>').value = fdate;
                                document.getElementById('<%=hdnToDate.ClientID %>').value = tdate;
                                return true;
                            }
                            else {
                                var CID = document.getElementById('<%=hdnClientID.ClientID %>').value;
                                if (CID == "") {
                                    alert('Enter Valid Client');
                                    document.getElementById('<%=hdnClientID.ClientID %>').value = "";
                                    document.getElementById('<%=hdnFromDate.ClientID %>').value = "";
                                    document.getElementById('<%=hdnToDate.ClientID %>').value = "";
                                    return false;
                                }
                                else {
                                    document.getElementById('<%=hdnFromDate.ClientID %>').value = fdate;
                                    document.getElementById('<%=hdnToDate.ClientID %>').value = tdate;
                                    return true;
                                }
                            }
                        }

                    }
                }
            }
        }
    </script>

    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <div class="defaultfontcolor">
                                        <asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Advance Client"
                                            meta:resourcekey="pnlPSearchResource1">
                                            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="dataheader3">
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 10%">
                                                                    <asp:Label runat="server" ID="lblClientName" Text="Client Name"></asp:Label>
                                                                </td>
                                                                <td style="width: 20%">
                                                                    <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                                        AutoComplete="off"  onblur="return ClearClientValues();"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                        MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                        OnClientItemSelected="OnselectedClientName" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                        Enabled="True" UseContextKey="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td style="width: 10%" align="left">
                                                                    <asp:Label ID="lblType" Text="Type" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                                                                </td>
                                                                <td style="padding-left: 1%">
                                                                    <asp:DropDownList ID="ddlType" runat="server" TabIndex="5" CssClass="ddlsmall">
                                                                        <asp:ListItem>Collection</asp:ListItem>
                                                                        <asp:ListItem>Refund</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 10%">
                                                                    <asp:Label ID="lblFromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
                                                                </td>
                                                                <td style="width: 20%">
                                                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall" TabIndex="1"
                                                                        onblur="javascript:return checkDate1(this);" ReadOnly="true"></asp:TextBox>
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFromDate"
                                                                        PopupButtonID="ImgFDate1" Enabled="True" OnClientDateSelectionChanged="checkDate1" />
                                                                    <asp:ImageButton ID="ImgFDate1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td style="width: 10%" align="left">
                                                                    <asp:Label ID="lblToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
                                                                </td>
                                                                <td style="padding-left: 1%">
                                                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall" TabIndex="3" onblur="javascript:return checkDate2(this);"
                                                                        ReadOnly="true"></asp:TextBox>
                                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtToDate"
                                                                        PopupButtonID="ImgFDate2" Enabled="True" OnClientDateSelectionChanged="checkDate2" />
                                                                    <asp:ImageButton ID="ImgFDate2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="padding-right: 400px; padding-top: 1%; padding-bottom: 1%;"
                                                        align="center">
                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" Height="25px" Width="50px"
                                                            CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                            OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" OnClientClick="javascript:return Validate()" />
                                                        &nbsp;
                                                        <%--<input id="btnCancel" class="btn" style="width: 50px;" type="button" value="Reset"
                                                            onclick="ClearData();" />--%>
                                                        <asp:Button ID="btnCancel" runat="server" Text="Reset" Height="25px" Width="50px"
                                                            CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                            OnClick="btnCancel_Click"/>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" />
                                                        <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="true"
                                                            Visible="true" Font-Size="12px" ForeColor="#000000" ToolTip="Save As Excel"><u>Export To XL</u></asp:LinkButton>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                            OnClientClick="return popupprint();" ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        <b id="printText" runat="server">
                                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" OnClientClick="return popupprint();"
                                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                                                meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourceKey="lblResultResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr id="tralldetails" runat="server">
                                                    <td align="center">
                                                        <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" meta:resourceKey="grdResultResource1"
                                                            HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                            ForeColor="#333333">
                                                            <Columns>
                                                                <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="DepositedDate" HeaderText="Deposited Date" meta:resourceKey="BoundFieldResource2">
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" meta:resourceKey="BoundFieldResource3">
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourceKey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="CollectedBy" HeaderText="Collected By" meta:resourceKey="BoundFieldResource6" />
                                                            </Columns>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                            <PagerStyle HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr id="trbeakupdetails" runat="server">
                                                    <td align="center">
                                                        <asp:GridView ID="gridRefund" runat="server" AutoGenerateColumns="False" meta:resourceKey="gridRefundResource1"
                                                            CssClass="mytable1 dataheader3" CellPadding="2" ForeColor="#333333">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                                <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="DepositedDate" HeaderText="Refunded Date" meta:resourceKey="BoundFieldResource2">
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" meta:resourceKey="BoundFieldResource3">
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="RefundAmount" HeaderText="Refund Amount" meta:resourceKey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="RefundedBy" HeaderText="Refunded By" meta:resourceKey="BoundFieldResource6" />
                                                            </Columns>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                            <PagerStyle HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr class="dataheaderInvCtrl">
                                                    <td align="center" colspan="2" class="defaultfontcolor">
                                                        <div id="divFooterNav" runat="server">
                                                            <asp:Label ID="Label2" runat="server" Text="Page"></asp:Label>
                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                            <asp:Label ID="Label3" runat="server" Text="Of"></asp:Label>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                            <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                                CssClass="btn" />
                                                            <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn" />
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                            <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                            <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                            <asp:Label ID="Label4" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" CssClass="Txtboxsmall" onkeypress="javascript:return ValidateOnlyNumeric(this);"></asp:TextBox>
                                                            <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues1();"
                                                                OnClick="btnGo_Click" CssClass="btn" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                <asp:HiddenField ID="hdnRefundstatus" runat="server" />
                                                <asp:HiddenField ID="hdnReceivedAmount" runat="server" />
                                                <asp:HiddenField ID="hdnRefundAmount" runat="server" />
                                                <asp:HiddenField ID="hdnTotalAmount" runat="server" />
                                                <asp:HiddenField ID="hdnClientID" runat="server" />
                                                <asp:HiddenField ID="hdnFromDate" runat="server" />
                                                <asp:HiddenField ID="hdnToDate" runat="server" />
                                            </table>
                                            <div align="center" id="printCashClosure" style="page-break-after: auto; display: none;"
                                                runat="server">
                                                <asp:GridView ID="PrintgrdResult" runat="server" AutoGenerateColumns="False" meta:resourceKey="grdResultResource1"
                                                    HeaderStyle-CssClass="dataheader1" CssClass="mytable1 dataheader3" CellPadding="2"
                                                    ForeColor="#333333" Width="100%">
                                                    <Columns>
                                                        <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="DepositedDate" HeaderText="Deposited Date" meta:resourceKey="BoundFieldResource2">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" meta:resourceKey="BoundFieldResource3">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmountDeposited" HeaderText="Amount Deposited" meta:resourceKey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                        <asp:BoundField DataField="CollectedBy" HeaderText="Collected By" meta:resourceKey="BoundFieldResource6" />
                                                    </Columns>
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                    <PagerStyle HorizontalAlign="Center" />
                                                </asp:GridView>
                                                <asp:GridView ID="PrintgridRefund" runat="server" AutoGenerateColumns="False" meta:resourceKey="gridRefundResource1"
                                                    CssClass="mytable1 dataheader3" CellPadding="2" ForeColor="#333333" Width="100%">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:BoundField DataField="Sno" HeaderText="Sno" meta:resourceKey="BoundFieldResource0" />
                                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="DepositedDate" HeaderText="Refunded Date" meta:resourceKey="BoundFieldResource2">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" meta:resourceKey="BoundFieldResource3">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="RefundAmount" HeaderText="Refund Amount" meta:resourceKey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource5" />
                                                        <asp:BoundField DataField="RefundedBy" HeaderText="Refunded By" meta:resourceKey="BoundFieldResource6" />
                                                    </Columns>
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                    <PagerStyle HorizontalAlign="Center" />
                                                </asp:GridView>
                                            </div>
                                            <input type="hidden" id="hdnBillStatus" runat="server"></input>
                                            <input type="hidden" id="hdnCollectionType" runat="server"></input>
                                            <asp:HiddenField ID="hdnAmt" runat="server" />
                                            <input id="bid" name="bid" type="hidden" />
                                            <asp:HiddenField ID="hdnClientPortal" runat="server" />
                                            <input type="hidden" runat="server" id="hdnclientName" />
                                            <input type="hidden" runat="server" id="hdnCustomerType" />
                                            <input type="hidden" runat="server" id="hdnClientTypeID" />
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
              
        <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnPNumber" name="PNumber" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="hdnpatientType" runat="server" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    
    </form>
</body>
</html>
