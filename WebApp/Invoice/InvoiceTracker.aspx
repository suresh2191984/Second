<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceTracker.aspx.cs" Inherits="Invoice_InvoiceTracker"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader"
    TagPrefix="uc7" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection"
    TagPrefix="DateCtrl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>
<%--<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    .notification-bubble
    {
        background-color: #F56C7E;
        border-radius: 9px 9px 9px 9px;
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.17) inset, 0 1px 1px rgba(0, 0, 0, 0.2);
        color: #FFFFFF;
        font-size: 9px;
        font-weight: bold;
        text-align: center;
        text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.2);
        -moz-transition: all 0.1s ease 0s;
        padding: 2px 3px 2px 3px;
    }
    .OutSrce
    {
        background-color: #D0FA58;
    }
    .AddScroll
    {
        height: 370px;
        width: 1200;
        padding-left: 50px;
        padding-top: 50px;
        overflow: auto;
    }
    .RemoveScroll
    {
        height: 370px;
        width: 1200;
    }
    .btn1, .btn
    {
        position: inherit !important;
    }
    .hidClum
    {
        display: none;
    }
</style>

<script language="javascript" type="text/javascript">
    function setAceWidth(source, eventArgs) {
        document.getElementById('aceDiv').style.width = 'auto';
    }


 function ClosePopUp() {
            $find('modalPopUp').hide();
        }
        
    function CheckHubName(codeType, TxtID) {
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_01") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_01") : "Select the Hub Name From List";

        var txtValue = document.getElementById(TxtID).value.trim();


        if (txtValue != '') {
            if (document.getElementById('hdnHubID').value == '0') {
                //alert('Select the Hub Name From List')
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtHub').focus();
                document.getElementById('txtHub').value = '';
                return false;
            }
        }
    }

    function CheckZoneName(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_03") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_03") : "Select the Zone Name From List";


        if (txtValue != '') {
            if (document.getElementById('hdntxtzoneID').value == '0') {
                //alert('Select the Zone Name From List')
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                document.getElementById('txtzone').focus();
                document.getElementById('txtzone').value = '';
                return false;
            }
        }
    }

    function ClearFields(Name) {
        if (Name == 'HUB') {
            document.getElementById('hdnHubID').value = '0';
        }
        else if (Name == 'ZON') {
            document.getElementById('hdntxtzoneID').value = '0';
        }
        else if (Name == 'CLIENT') {
        if ($('#txtclient').val() == '') {
            document.getElementById('hdnClientID').value = '0';
        }
            
        }

    }

    function OnHubSelected(source, eventArgs) {
        document.getElementById('txtHub').value = eventArgs.get_text();
        document.getElementById('hdnHubID').value = eventArgs.get_value();

    }

    function Onzoneselected(source, eventArgs) {
        document.getElementById('txtzone').value = eventArgs.get_text();
        document.getElementById('hdntxtzoneID').value = eventArgs.get_value();

    }
</script>

<script language="javascript" type="text/javascript">
    jQuery(function($) {
        //debugger;
        var allCkBoxSelector = 'input[id*="chkAllItem"]:checkbox';
        var checkBoxSelector = '#<%=grdInvoiceBill.ClientID%> input[id*="chkInvoiceItem"]:checkbox';
        function ToggleCheckUncheckAllOptionAsNeeded() {
            var totalCkboxes = $(checkBoxSelector),
                    checkedCheckboxes = totalCkboxes.filter(":checked"),
                    noCheckboxesAreChecked = (checkedCheckboxes.length == 0),
                    allCkboxesAreChecked = (totalCkboxes.length == checkedCheckboxes.length);
            $(allCkBoxSelector).attr('checked', allCkboxesAreChecked);
        }

        $(allCkBoxSelector).live('click', function() {
            $(checkBoxSelector).attr('checked', $(this).is(':checked'));
            ToggleCheckUncheckAllOptionAsNeeded();
        });
        $(checkBoxSelector).live('click', ToggleCheckUncheckAllOptionAsNeeded);
        ToggleCheckUncheckAllOptionAsNeeded();
    });
    function isSpclChar(e) {
        var key;
        var isCtrl = false;
        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }
        //*************To block slash(/) into text box change the key value to 48***************************//
        if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }
        return isCtrl;
    }
    function IsShowprinter() {
        if (document.getElementById("ddlOption").value == 'Show_Print') {
            document.getElementById('ddlLocationPrinter').style.display = "block";
            document.getElementById('lblLocationPrinter').style.display = "block";
        }
        else {
            document.getElementById('ddlLocationPrinter').style.display = "none";
            document.getElementById('lblLocationPrinter').style.display = "none";

        }
    }
    function pdfPrint() {
        document.getElementById("hdnPDFType").value = 'prtpdf';
        //            var prtContent = document.getElementById('Divpdf');
        //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1000,height=500');
        //            //alert(WinPrint);
        //            WinPrint.document.write(prtContent.innerHTML);
        //            WinPrint.document.close();
        //            WinPrint.focus();
        //            WinPrint.print();

    }
    function validatePageNumber() {
        if (document.getElementById('txtpageNo').value == "") {
            return false;
        }
    }
    function ClearVal() {
        document.getElementById('txtclient').value = "";
        document.getElementById('hdnClientID').value = "0";
    }

    function setContextVal(ID) {
        if ($find('AutoCompleteExtender2') != null) {
            var cusID = document.getElementById('drpCustomerType').value;
            var Type = 0;
            if (Number(cusID) > Number(0)) {
                var orgID = '<%= OrgID %>';
                $find('AutoCompleteExtender2').set_contextKey(orgID + '~' + Type + '~' + cusID);
            }
            else {
                //                alert('Please select client type');
                //                document.getElementById(ID).value = "";
                //                document.getElementById('drpCustomerType').focus();
                //                return false;
                var orgID = '<%= OrgID %>';
                $find('AutoCompleteExtender2').set_contextKey(orgID + '~' + '0' + '~' + cusID);
            }
        }
    }
    function Cleardata() {
        var grid = document.getElementById('grdInvoiceBill');
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_04") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_04") : "SMS Sent successfully !!";

        if (grid != null) {
            var GrdLenth = grid.rows.length;
            for (var i = 1; i < GrdLenth; i++) {
                if (grid.rows[i].cells[0].childNodes[0].type == "checkbox") {
                    grid.rows[i].cells[0].childNodes[0].checked = false;
                }
            }
            //alert('SMS Sent successfully !!');
            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
            document.getElementById('ddlOption').value = "0"
        }
    }
    function redirectPage() {
        $("[id$='btnPostBackUrl']").click();
    }
    function ChkMultipleValues() {
        var flag = 0;
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_05") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_05") : "Select atleast one item for payment";
        var UsrAlrtMsg4 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_06") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_06") : "No Due Amount to Pay";
        var UsrAlrtMsg5 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_07") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_07") : "Select atleast one item to view invoice report !!";
        var UsrAlrtMsg6 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_08") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_08") : "Viewing multiple invoice report is not allowed !!";
        var UsrAlrtMsg7 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_09") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_09") : "Select atleast one item to send SMS !!";
        var UsrAlrtMsg8 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_10") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_10") : "Select an option to proceed !!";




        document.getElementById('hdnCheckID').value = "0";
        $('table[id$="grdInvoiceBill"] input[type=checkbox]:checked').each(function() {
            flag = flag + 1;
        });

        var ddlValue = document.getElementById('<%=ddlOption.ClientID %>').options[document.getElementById('<%=ddlOption.ClientID %>').selectedIndex].value;
        if (ddlValue == "Collect_InvoicePayment_Receipts") {
            if (flag == 0) {
                //alert('Select atleast one item for payment');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('chkInvDraft').checked == true) {
            return false;
            }
            else {
                var checkBoxSelector = '#<%=grdInvoiceBill.ClientID%> input[id*="chkInvoiceItem"]:checkbox';

                var tbl = $("[id$=grdInvoiceBill]");
                var rows = tbl.find('tr');

                for (var index = 1; index < rows.length; index++) {

                    var row = rows[index];

                   var checked = $(row).find("[id*=chkInvoiceItem]").is(':checked');

                    var lblTaxAmount = $(row).find("[id*=lblTaxAmount]").text();

                    if (checked) {
                        if (lblTaxAmount <= 0) {
                            ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                            //alert("No Due Amount to Pay");
                            return false;

                        }
                        else {
                            redirectPage();
                            document.getElementById('hdnCheckID').value = "0";
                        }
                    }
                }
            }
        }

        if (ddlValue == "Collect_InvoicePayment_Collect") {
            if (flag == 0) {
                //alert('Select atleast one item for payment');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('chkInvDraft').checked == true) {
                return false;
            }
            else {
                var checkBoxSelector = '#<%=grdInvoiceBill.ClientID%> input[id*="chkInvoiceItem"]:checkbox';

                var tbl = $("[id$=grdInvoiceBill]");
                var rows = tbl.find('tr');

                for (var index = 1; index < rows.length; index++) {

                    var row = rows[index];

                    var checked = $(row).find("[id*=chkInvoiceItem]").is(':checked');

                    var lblTaxAmount = $(row).find("[id*=lblTaxAmount]").text();

                    if (checked) {
                        if (lblTaxAmount <= 0) {
                            ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                            //alert("No Due Amount to Pay");
                            return false;

                        }
                        else {
                            redirectPage();
                            document.getElementById('hdnCheckID').value = "0";
                        }
                    }
                }
            }

        }
        if (ddlValue == "Invoice_Tracker_View Invoice") {
            if (flag == 0) {
                //alert('Select atleast one item to view invoice report !!');
                ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                return false;
            }
            if (flag > 1) {
                // alert('Viewing multiple invoice report is not allowed !!');
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                return false;
            }
        }
        if (ddlValue == "SMS") {
            if (flag == 0) {
                // alert('Select atleast one item to send SMS !!');
                ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
                return false;
            }
        }
        if (document.getElementById('<%=ddlOption.ClientID %>').value == "0") {
            // alert('Select an option to proceed !!');
            ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
            document.getElementById('<%=ddlOption.ClientID %>').focus();
            return false;
        }
    }
    function setContextValforZone(ID) {
        if ($find('AutoCompleteExtenderOnzone') != null) {
            var HubID = document.getElementById('hdnHubID').value;

            $find('AutoCompleteExtenderOnzone').set_contextKey('zone' + '~' + HubID);
        }
    }
    var prevClientID = '';
    function onChaangeChk(obj) {
        var val = $('#' + obj).closest('tr').find('.getClientID').attr('id');
        if ($('#' + obj).closest('table').find('tr input[type="checkbox"]:checked').length == 1) {
            prevClientID = $('#' + val)[0].innerText;
        }
        else {
            var Ckhid = $('#' + val).closest('tr').find('input[type="checkbox"]').attr('id');
            if ($('#' + val)[0].innerText == prevClientID) {



                $('#' + Ckhid).attr('checked', true);
            }
            else {
                alert('Please Select Particular Client Alone!!!!');
                $('#'+Ckhid).attr('checked', false);
            }

        }
        if (prevClientID != '') {

        }
        else {
            prevClientID = $('#' + val)[0].innerText;
        }



                if (document.getElementById(obj).checked) {
                    document.getElementById('hdnGetValue').value = obj + '^';
                }
               else {
                   var x = document.getElementById('hdnGetValue').value.split('^');
                   document.getElementById('hdnGetValue').value = '';
                    for (i = 0; i < x.length; i++) {
                       if (x[i] != '') {
                           if (x[i] != obj) {
                               document.getElementById('hdnGetValue').value = x[i] + '^';
                           }
                       }
                   }
               }
    }
    function checkForValues() {
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_11") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_11") : "Please Enter The Page No";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_12") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_12") : "Please Enter Correct Page No";


        if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
            //var userMsg = 'Please Enter The Page No';

            if (UsrAlrtMsg != null) {
                //alert(userMsg);
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            }

            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {

            // var userMsg = 'Please Enter Correct Page No';
            if (UsrAlrtMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }

            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
            // var userMsg = 'Please Enter Correct Page No';
            if (UsrAlrtMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }

            return false;
        }
    }
    function ClientSelected(source, eventArgs) {
        var list = eventArgs.get_value().split('^');
        var ID = "0";
        if (list[0] != "") {
            ID = list[0];
        }
        document.getElementById('hdnClientID').value = ID;
    }

    function CheckToSaveData() {

        var Reportshow = false;
        document.getElementById('hdnShowReport').value = Reportshow;

        var inVoiceNo = document.getElementById('txtInvoiceNo').value;
        var customerType = document.getElementById('drpCustomerType').value;

        //        if (inVoiceNo == "") {
        //            if (customerType == '0') {
        //                alert('Please Select Business Type');
        //                document.getElementById('drpCustomerType').focus();
        //                return false;
        //            }
        //        }
    }
    function setAceWidth(source, eventArgs) {
        document.getElementById('aceDiv').style.width = 'auto';
    }
    function setZoneWidth(source, eventArgs) {
        document.getElementById('ZoneDiv').style.width = 'auto';
    }
    function popupprint1Act() {
        //document.getElementById('divdispatchdetails').style.display = "none";
        $('#PanellAckChild').removeClass('AddScroll').addClass('RemoveScroll');
        var prtContent = document.getElementById('DivackChild');
        var PanellAckChild = document.getElementById('PanellAckChild');
        PanellAckChild.removeAttribute(scroll);
        var WinPrint = window.open('', '', 'letf=20,top=20,toolbar=0,scrollbars=yes,status=0,width=1524,height=1068');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        // WinPrint.close();
    }
    function popupprint1() {
        $('#table_GroupItem').removeClass('AddScroll').addClass('RemoveScroll');
        var prtContent = document.getElementById('dvInvstigationDetails');
        var table_GroupItem = document.getElementById('table_GroupItem');
        table_GroupItem.removeAttribute(scroll);
        var WinPrint = window.open('', '', 'letf=20,top=20,toolbar=0,scrollbars=yes,status=0,width=1524,height=1068');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        // WinPrint.close();
    }
    function ShowdispatchList() {

        document.getElementById('divdispatchdetails').style.display = "block";

    }
    function ShowdispatchListAct() {

        document.getElementById('divAck').style.display = "block";

    }
    function popupClosed() {

        document.getElementById('divdispatchdetails').style.display = "none";
        IsShowprinter();
    }

    function popupClosedAct() {

        document.getElementById('divAck').style.display = "none";
    }
    function checkEmail() {
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_13") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_13") : "Please provide a valid email address";

        var email = document.getElementById('<%=txtClientEmail.ClientID %>');
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!filter.test(email.value)) {
            //alert('Please provide a valid email address');
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            email.focus;
            email.value = '';
            return false;
        }
        else {
            return true;
        }

    }
</script>

<style>
    .AutoCompletesearchBox1
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 15px;
        width: 150px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        background-image: url('../Images/magnifying-glass.png');
        background-repeat: no-repeat;
        padding-left: 20px;
    }
    .AutoCompletesearchBox2
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 15px;
        width: 250px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        background-image: url('../Images/magnifying-glass.png');
        background-repeat: no-repeat;
        padding-left: 20px;
    }
</style>
<head id="Head1" runat="server">
    <title>
        <%--Invoice Tracker--%><%=Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_001%>
    </title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <div class="dataheader3">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourceKey="lblResultResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlPSearch" runat="server" CssClass="w-100p" meta:resourcekey="pnlPSearchResource1">
                            <table class="dataheader2 defaultfontcolor w-100p">
                                <tr>
                                    <td class="w-8p a-left">
                                        <asp:Label ID="lblInvoiceNo" Text="Invoice No:" runat="server" meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                    </td>
                                    <td class="w-10p a-left">
                                        <asp:TextBox ID="txtInvoiceNo"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                            runat="server" CssClass="small" TabIndex="1" meta:resourcekey="txtInvoiceNoResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-8p a-left">
                                        <asp:Label ID="lblBusinessType" runat="server" Text="Business Type:" meta:resourcekey="lblBusinessTypeResource1"></asp:Label>
                                    </td>
                                    <td class="w-12p a-left">
                                        <asp:DropDownList ID="drpCustomerType" runat="server" AutoPostBack="True" TabIndex="2"
                                            CssClass="ddlsmall" onclick="javascript:ClearVal();" OnSelectedIndexChanged="drpCustomerType_SelectedIndexChanged"
                                            meta:resourcekey="drpCustomerTypeResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-8p">
                                        <asp:Label ID="lblClientName" Text="Client Name:" runat="server" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                    </td>
                                    <td class="w-30p a-left">
                                        <asp:TextBox ID="txtclient" onkeypress="setContextVal(this.id);" CssClass="AutoCompletesearchBox2 small"
                                            runat="server" TabIndex="3" onchange="javascript:return ClearFields('CLIENT');"
                                            meta:resourcekey="txtclientResource1"></asp:TextBox>
                                        <div id="aceDiv">
                                        </div>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtclient"
                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientNamebyClientType"
                                            ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                            OnClientItemSelected="ClientSelected" CompletionListElementID="aceDiv" OnClientShown="setAceWidth">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-8p a-left">
                                        <asp:Label ID="Label5" Text="Hub Name:" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                    </td>
                                    <td class="w-10p a-left">
                                        <asp:TextBox ID="txtHub" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1 small"
                                            onBlur="CheckHubName('HUB',this.id);"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                            onchange="javascript:return ClearFields('HUB');" meta:resourcekey="txtHubResource1"
                                            TabIndex="4"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderOnHub" runat="server" TargetControlID="txtHub"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                            OnClientItemSelected="OnHubSelected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                            Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td class="w-8p a-left">
                                        <asp:Label ID="Label6" Text="Zone Name:" runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                                    </td>
                                    <td class="w-10p a-left">
                                        <asp:TextBox ID="txtzone" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1 small"
                                            onblur="CheckZoneName('Zone',this.id);" onkeyup="javascript:return ValidateOnlyNumeric(event);"
                                            onkeypress="setContextValforZone(this.id);" onchange="javascript:return ClearFields('ZON');"
                                            meta:resourcekey="txtzoneResource1" TabIndex="5"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderOnzone" runat="server" TargetControlID="txtzone"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                            OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                            Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td class="w-8p a-left">
                                        <asp:Label ID="lblInvoiceCycle" runat="server" Text="Invoice Cycle:" meta:resourcekey="lblInvoiceCycleResource1"></asp:Label>
                                    </td>
                                    <td class="w-12p a-left">
                                        <asp:DropDownList ID="dropInvoiceCycle" runat="server" CssClass="ddlsmall" meta:resourcekey="dropInvoiceCycleResource1">
                                            <%--<asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource12" Text="--Select--"></asp:ListItem>
                                            <asp:ListItem Value="0.5" Text="15 Days" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="1 Month" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        <asp:TextBox ID="txtFrom" TabIndex="6" CssClass="small" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                    </td>
                                    <td class="a-left w-8p">
                                        <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        &nbsp;<asp:TextBox ID="txtTo" TabIndex="7" CssClass="small" runat="server" meta:resourcekey="txtToResource1"></asp:TextBox>
                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                    </td>
                                    <td class="a-left" colspan="2">
                                        <asp:CheckBox ID="chkInvDraft" runat="server" TabIndex="3" meta:resourcekey="chkInvDraftResource1" />
                                        <asp:Label ID="lblInvDraft" runat="server" Text="IS-Draft" meta:resourcekey="lblInvDraftResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" class="a-center">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return CheckToSaveData()"
                                            CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                    </td>
                                </tr>
                            </table>
                            <table id="GrdHeader" runat="server" class="w-100p" style="display: none">
                                <tr>
                                    <td class="a-right" colspan="7">
                                        <asp:Button ID="btnchklistprint" runat="server" Text="CheckList Print" class="btn"
                                            OnClientClick="return ShowdispatchList();" meta:resourcekey="btnchklistprintResource1"/>
                                        <asp:Button ID="btnActprint" runat="server" Text="Ack Print" class="btn" OnClientClick="return ShowdispatchListAct();" meta:resourcekey="btnActprintResource1"/>
                                        <asp:Button ID="btnExcelEprt" runat="server" Text="Export Excel" class="btn" OnClick="btnExcelEprt_Click" meta:resourcekey="btnExcelEprtResource1"/>
                                    </td>
                                </tr>
                                <tr class="dataheader1" >
                                    <td runat="server" class="a-center w-4p" id="tdActionse">
                                        <asp:CheckBox ID="chkAllItem" runat="server" ToolTip="Select Row" Checked="false">
                                        </asp:CheckBox>
                                    </td>
                                    <td class="a-center w-15p" runat="server">
                                        <asp:Label ID="lblhdrInvoiceNo" runat="server" Text="Invoice No" meta:resourcekey="lblhdrInvoiceNoResource1"></asp:Label>
                                    </td>
                                    <td class="a-center w-13p" runat="server">
                                        <asp:Label ID="lblInvoiceDate" runat="server" Text="Invoice Date" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                    </td>
                                    <td class="a-center w-32p" runat="server">
                                        <asp:Label ID="lblhdrClientName" runat="server" Text="ClientName" meta:resourcekey="lblhdrClientNameResource1"></asp:Label>
                                    </td>
                                    <td class="a-center w-12p" runat="server">
                                        <asp:Label ID="LblhdrGrossAmount" runat="server" Text="Gross Amount" meta:resourcekey="LblhdrGrossAmountResource1"></asp:Label>
                                    </td>
                                    <td class="a-center w-12p" runat="server">
                                        <asp:Label ID="LblhdrNetAmount" runat="server" Text="NetAmount" meta:resourcekey="LblhdrNetAmountResource1"></asp:Label>
                                    </td>
                                    <td class="a-center w-15p" runat="server">
                                        <asp:Label ID="lblhdrDue" runat="server" Text="Due" meta:resourcekey="lblhdrDueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table runat="server" id="tblgrd" class="w-100p">
                                <tr>
                                    <td>
                                        <asp:GridView ID="GridView1" runat="server" CssClass="gridView w-100p m-auto" AutoGenerateColumns="false"
                                            Style="display: none">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Bill.No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateField1Resource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblInvoiceNumber" Text='<%# Eval("InvoiceNumber") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Client Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="TemplateField2Resource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblClientName" Text='<%# Eval("Comments") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CreatedAt" HeaderText="Bill.Date" DataFormatString="{0:d}"
                                                    HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundField2Resource2"/>
                                                <asp:TemplateField HeaderText="Total Amt" HeaderStyle-HorizontalAlign="Left"  meta:resourcekey="TemplateField3Resource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAmount" Text='<%# Eval("GrossValue") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Zone" HeaderStyle-HorizontalAlign="Left"  meta:resourcekey="TemplateField4Resource4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblZoneCode" Text='<%# Eval("ZoneCode") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Discount" HeaderStyle-HorizontalAlign="Left"  meta:resourcekey="TemplateField5Resource5">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDisAmount" Text='<%# Eval("DiscountAmt") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="NetValue" HeaderText="Invoice Amount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="ReceivedAmt" HeaderText="Received Amount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="DiscountAmount" HeaderText="Discount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="TDSAmount" HeaderText="TDS" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    
                                                <%--<asp:TemplateField HeaderText="SaP Lab Code" HeaderStyle-HorizontalAlign="left" meta:resourcekey="TemplateField6Resource6">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSaPLabCode" Text='<%# Eval("SaPLabCode") %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                 <asp:TemplateField HeaderText="Due" HeaderStyle-HorizontalAlign="Center"  meta:resourcekey="TemplateField11Resource11">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTaxAmount" Text='<%# Eval("TaxAmount","{0:0.00}")%>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                 <asp:BoundField DataField="CreditAmount" HeaderText="Credit" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="DebitAmount" HeaderText="Debit" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="WriteOffAmt" HeaderText="Write Off " DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="TTOD" HeaderText=" Pending outstanding" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="VolumeDiscountAmt" HeaderText=" Total Outstanding" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                            <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                                        <div class="dataheader3">
                                            <asp:GridView ID="grdInvoiceBill" runat="server" CssClass="mytable gridView w-100p m-auto"
                                                AutoGenerateColumns="false" DataKeyNames="InvoiceID,InvoiceNumber,ClientID,Comments,ReportTemplateID"
                                                OnRowDataBound="grdInvoiceBill_RowDataBound" OnRowCommand="grdInvoiceBill_RowCommand" OnPageIndexChanging="grdInvoiceBill_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="Center">
                                                        <%--<HeaderTemplate>
                                                                                    <asp:CheckBox ID="chkAllItem" runat="server" />
                                                                                </HeaderTemplate>--%>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkInvoiceItem" class="CheckClient" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Invoice ID" HeaderStyle-HorizontalAlign="Center" Visible="false" meta:resourcekey="TemplateField6Resource6">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvoiceID" Text='<%# Eval("InvoiceID") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Client ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidClum"
                                                        HeaderStyle-CssClass="hidClum" meta:resourcekey="TemplateField7Resource7">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblClientID" class="getClientID" Text='<%# Eval("ClientID") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Invoice Date" DataFormatString="{0:d}"
                                                        HeaderStyle-HorizontalAlign="Center" meta:resourcekey="BoundField5Resource5" />
                                                    <asp:TemplateField HeaderText="Client Name" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateField9Resource9">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvoicePeriod" Text='<%# Eval("IsNotifyComplete") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Invoice No" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateField8Resource8">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvoiceNumber" Text='<%# Eval("InvoiceNumber") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Client Name" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateField9Resource9">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblClientName" Text='<%# Eval("Comments") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--
                                                                            <asp:BoundField DataField="InvoiceID" HeaderText="Invoice ID" HeaderStyle-HorizontalAlign="Center"
                                                                                Visible="false" />--%><%--
                                                                            <asp:BoundField DataField="ClientID" HeaderText="Invoice ID" HeaderStyle-HorizontalAlign="Center"
                                                                                Visible="false" />--%>
                                                    <%--<asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice No" HeaderStyle-HorizontalAlign="Center" />--%>
                                                    <%-- <asp:TemplateField HeaderText="Gross Amount" HeaderStyle-HorizontalAlign="Center"
                                                        meta:resourcekey="TemplateField10Resource10">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAmount" Text='<%# Eval("GrossValue") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:BoundField DataField="NetValue" HeaderText="Invoice Amount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="ReceivedAmt" HeaderText="Received Amount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                 
                                                    <asp:TemplateField HeaderText="Due" HeaderStyle-HorizontalAlign="Center"  meta:resourcekey="TemplateField11Resource11">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTaxAmount" Text='<%# Eval("TaxAmount","{0:0.00}")%>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="CreditAmount" HeaderText="Credit" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="DebitAmount" HeaderText="Debit" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="WriteOffAmt" HeaderText="Write Off " DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="TTOD" HeaderText=" Pending outstanding" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="VolumeDiscountAmt" HeaderText=" Total Outstanding" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:TemplateField HeaderText="Image" Visible="false" HeaderStyle-HorizontalAlign="Center" >
                                                        <ItemTemplate>
                                                           <asp:ImageButton ID="ImgInvoice" runat="server"  ImageUrl="~/Images/BillIcon.jpg" CommandArgument="<%# Container.DataItemIndex %>" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                    PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                <PagerStyle HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </div>
                                        </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                    <td class="defaultfontcolor a-center">
                                        <asp:Label ID="Label2" runat="server" Text="Page"  meta:resourcekey="Label2Resource11"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="Label3" runat="server" Text="Of" meta:resourcekey="Label3Resource11"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                        <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource11"/>
                                        <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" meta:resourcekey="btnNextResource11"/>
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label4" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label4Resource11"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall w-30"   onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClientClick="javascript:return validatePageNumber();"
                                            OnClick="btnGo_Click" meta:resourcekey="btnGoResource11"/>
                                        <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                    </td>
                                </tr>
                            </table>
                            <table id="tblprintaction" class="w-50p m-auto" runat="server">
                                <tr id="trddl" runat="server" style="display: none" border="1">
                                    <td class="w-20p">
                                        <asp:Label ID="Label1" runat="server" Text=" Select a Action" meta:resourcekey="Label1Resource12"></asp:Label>
                                        <asp:DropDownList runat="server" CssClass="ddlsmall" ID="ddlOption" onchange="javascript:IsShowprinter();">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-20p">
                                        <asp:Label ID="lblLocationPrinter" runat="server" Text=" Select a Printer" meta:resourcekey="lblLocationPrinterResource12"></asp:Label>
                                        <asp:DropDownList ID="ddlLocationPrinter" CssClass="ddlsmall" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-10p a-left">
                                        <asp:Button ID="btnSendsms" runat="server" Text="GO" class="btn" OnClientClick="javascript:return ChkMultipleValues();"
                                            OnClick="btnSendsms_Click" meta:resourcekey="btnSendsmsResource12"/>
                                        <asp:Button ID="btnPostBackUrl" OnClick="btnPostBackUrl_Click" Style="display: none;"
                                            runat="server" Text="GO" class="btn" meta:resourcekey="btnPostBackUrlResource12"/>
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="hdnResult" runat="server" Value="0" />
                            <asp:GridView ID="grdPatientView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CssClass="mytable1 gridView w-100p m-auto" DataKeyNames="InvoiceID" ForeColor="#333333"
                                OnRowDataBound="grdPatientView_RowDataBound" PageSize="5" meta:resourcekey="grdPatientViewResource1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Invoice Report" meta:resourcekey="TemplateFieldinvoiceResource1">
                                        <ItemTemplate>
                                            <div class="a-center">
                                                <table class="dataheaderInvCtrl w-100p" style="border-collapse: collapse;">
                                                    <tr>
                                                        <td class="a-right w-25p" style="background-color: #3a86da;">
                                                            <asp:Label ID="lblVisitDate" runat="server" ForeColor="White" meta:resourcekey="lblVisitDateResource1"
                                                                Text="Invoice Date"></asp:Label>
                                                        </td>
                                                        <td class="a-left w-25p" style="background-color: #3a86da;">
                                                            <asp:Label ID="lblDate" runat="server" ForeColor="White" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center" colspan="2">
                                                            <asp:GridView ID="grdOrderedinv" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p m-auto"
                                                                ForeColor="Black" meta:resourcekey="grdOrderedinvResource1" PageSize="100">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Comments" HeaderText="ClientName" meta:resourcekey="BoundFieldclientResource1">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="FromDate" HeaderText="From Date" meta:resourcekey="BoundFieldfromResource2" />
                                                                    <asp:BoundField DataField="ToDate" HeaderText="To Date" meta:resourcekey="BoundFieldToResource3" />
                                                                    <asp:BoundField DataField="InvoiceID" HeaderText="Invoice ID" meta:resourcekey="BoundFieldidResource4"
                                                                        Visible="False">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:HiddenField ID="hdnCheckID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnGetValue" runat="server" Value="" />
                        </asp:Panel>
                        <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                        <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                            TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                            CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                        </ajc:ModalPopupExtender>
                        <asp:Panel ID="pnlReportPreview" Height="500px" Width="1000px" CssClass="modalPopup dataheaderPopup"
                            runat="server" meta:resourcekey="pnlShowReportPreviewResource1" Style="display: none">
                            <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                <table class="w-100p">
                                    <tr>
                                        <td class="defaultfontcolor a-right v-middle">
                                            <asp:Button ID="btnpdf" runat="server" Text="Print" OnClientClick="return pdfPrint();"
                                                CssClass="btn h-18" OnClick="btnSendsms_Click" meta:resourcekey="btnpdfResource1" />
                                            &nbsp;&nbsp;
                                            <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" class="h-18"
                                                runat="server" alt="Close" style="cursor: pointer;" onclick="javascript:IsShowprinter();" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table class="w-100p">
                                <tr>
                                    <td class="v-top">
                                        <table id="Table2" class="w-100p" runat="server">
                                            <tr id="Tr8" runat="server">
                                                <td id="Td15" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                    <div id="Div3" style="display: block;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('Div3','Div4','tblReportDetails',1);
										    showResponses('Div55','Div66','ACX3responses22',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
										showResponses('Div55','Div66','ACX3responses22',0);">&nbsp;<asp:Label ID="Label16"
                                            runat="server" Text="Invoice Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                    <div id="Div4" style="display: none;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('Div3','Div4','tblReportDetails',0);showResponses('Div55','Div66','ACX3responses22',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);
										showResponses('Div55','Div66','ACX3responses22',1);">
                                                            <asp:Label ID="Label17" runat="server" Text=" Invoice Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tblReportDetails" class="w-100p" style="display: none;">
                                            <tr>
                                                <td>
                                                    <%-- <ucPatientdet:PatientDetails ID="uctPatientDetail1" runat="server" />--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="colorforcontent w-30p h-23 a-left">
                                                    <div id="Div55" style="display: none;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('Div55','Div66','ACX3responses22',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                            &nbsp;<asp:Label ID="Label18" runat="server" Text="Show PDF" meta:resourcekey="Label18Resource1"></asp:Label></span></div>
                                                    <div id="Div66" style="display: block;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                            onclick="showResponses('Div55','Div66','ACX3responses22',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                            <asp:Label ID="Label20" runat="server" Text="PDF Viewer" meta:resourcekey="Label20Resource1"></asp:Label></span></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="ACX3responses22" class="w-100p h-100p">
                                            <tr>
                                                <td class="a-center">
                                                    <div id="Divpdf" runat="server" class="w-100p h-100p">
                                                        <iframe runat="server" id="frameReportPreview" name="myname" style="width: 985px;
                                                            height: 400px; overflow: none;"></iframe>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div id="divdispatchdetails" style="display: none;">
                            <asp:Panel ID="PanelGroup" runat="server" Style="height: 420px; width: 1200px;" CssClass="modalPopup dataheaderPopup">
                                <div id="dvInvstigationDetails" runat="server" style="display: block;">
                                    <asp:Panel ID="table_GroupItem" runat="server" class="AddScroll">
                                        <table class="a-center">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Label CssClass="font16 h-30" Visible="False" Style="font-family: Trebuchet MS"
                                                        ID="lblZOneName" Font-Bold="True" Width="400px" runat="server" meta:resourcekey="lblZOneNameResource1" />
                                                    <asp:Label CssClass="font19 h-30" ID="Label25" Style="font-family: Trebuchet MS"
                                                        Font-Bold="True" Width="300px" runat="server" Text="ZONE WISE INVOICE REGISTER - "
                                                        meta:resourcekey="Label25Resource1" />
                                                    <asp:Label CssClass="font19 h-30" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                        Font-Bold="True" runat="server" meta:resourcekey="lblprintingperiodResource1" />
                                                    <br />
                                                    <asp:Label CssClass="font16 h-30" Style="font-family: Trebuchet MS" ID="lblPrintedAt"
                                                        Font-Bold="True" Width="250px" runat="server" meta:resourcekey="lblPrintedAtResource1" />
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataList ID="outerDataList" runat="server" ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-HorizontalAlign="Left" meta:resourcekey="outerDataListResource1">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            <HeaderTemplate>
                                                <asp:Label CssClass="font12 h-3" Font-Bold="True" ID="Label26" Width="1200px" runat="server"
                                                    Text="-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
                                                    meta:resourcekey="Label26Resource1" />
                                                <br />
                                                <asp:Label CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS" FontBold="true"
                                                    ID="lblBillNo" Font-Bold="True" runat="server" Text="Bill No" meta:resourcekey="lblBillNoResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblClientName" CssClass="font16 h-20"
                                                    Font-Bold="True" runat="server" Width="350px" Text="Party Name" meta:resourcekey="lblClientNameResource2" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblBillDate" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="Bill Date" meta:resourcekey="lblBillDateResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblTotalAmount" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="Total Amt" meta:resourcekey="lblTotalAmountResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblDiscount" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="Discount" meta:resourcekey="lblDiscountResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblZone" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="Zone" meta:resourcekey="lblZoneResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblBalance" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="Balance" meta:resourcekey="lblBalanceResource1" />
                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblSAPLabCode" CssClass="font16 h-20 w-100"
                                                    Font-Bold="True" runat="server" Text="SAPLabCode" meta:resourcekey="lblSAPLabCodeResource1" />
                                                <%--<asp:Label Style="font-family: Trebuchet MS" ID="lblStampSign" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="Stamp & Sign" />
                                                                                            <br />--%>
                                                <asp:Label CssClass="font11 h-15" ID="Label27" Font-Bold="true" Width="1200px" runat="server"
                                                    Text="--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"  meta:resourcekey="Label27Resource1"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <%--<br />--%>
                                                <asp:Label ID="Label10" CssClass="font16 h-20" runat="server" meta:resourcekey="Label10Resource1" />
                                                <asp:Label ID="Label5" CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("InvoiceNumber") %>'  />
                                                <asp:Label ID="lblClientName" CssClass="font16 h-20" Width="350px" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("Comments") %>'  />
                                                <asp:Label ID="lblBillDate" CssClass="font16 h-20" Width="100px" Style="font-family: Trebuchet MS"
                                                    DataFormatStrin="{0:d}" runat="server" Text='<%# bind("BilledDate") %>' />
                                                <asp:Label ID="lblTotalAmt" CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("GrossValue") %>' meta:resourcekey="lblTotalAmtResource1" />
                                                <asp:Label ID="lblDiscount" FCssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("DiscountAmt") %>'  />
                                                <asp:Label ID="lblZone" CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("ZoneCode") %>'  />
                                                <asp:Label ID="lblBalance" CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("NetValue") %>'  />
                                                <asp:Label ID="lblSapLabCode" CssClass="font16 h-20 w-100" Style="font-family: Trebuchet MS"
                                                    runat="server" Text='<%# bind("SaPLabCode") %>'  />
                                                <%--<asp:DataList ID="dlstDispatchList" runat="server">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="Label5" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("BillNo") %>' />
                                                                                        <asp:Label ID="lblClientName" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("ClientName") %>' />
                                                                                        <asp:Label ID="lblBillDate" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("BillDate") %>' />
                                                                                        <asp:Label ID="lblTotalAmt" Font-Size="16px" Height="20px" Width="250px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("TotalAmount") %>' />
                                                                                        <asp:Label ID="lblDiscount" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Discount") %>' />
                                                                                        <asp:Label ID="lblZone" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Zone") %>' />
                                                                                        <asp:Label ID="lblBalance" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Balance") %>' />
                                                                                        <asp:Label ID="lblSapLabCode" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("SAPLabCode") %>' />
                                                                                    </ItemTemplate>
                                                                                </asp:DataList>--%>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <%--<asp:DataList ID="ZoneDatList" runat="server" OnItemDataBound="ZoneDatList_ItemDataBound">
                                                                    <ItemTemplate>
                                                                        <table>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Label Font-Size="19px" ID="Label25" Style="font-family: Trebuchet MS" Height="30px"
                                                                                        Font-Bold="true" Width="300px" runat="server" Text="ZONE WISE BILL REGISTER - " />
                                                                                    <asp:Label Font-Size="19px" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                                                        Height="30px" Font-Bold="true" runat="server" Text="" />
                                                                                    <br />
                                                                                    <asp:Label Font-Size="16px" Style="font-family: Trebuchet MS" ID="lblPrintedAt" Height="30px"
                                                                                        Font-Bold="true" Width="250px" runat="server" Text="" />
                                                                                    <br />
                                                                                    <asp:Label Font-Bold="true" Font-Size="20px" Style="page-break-before: always" ID="ZoneName"
                                                                                        runat="server" Text='<%# Eval("ZoneName") %>' />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left">
                                                                                    <br />
                                                                                    <asp:DataList ID="outerDataList" runat="server">
                                                                                        <HeaderTemplate >
                                                                                            <asp:Label Font-Size="12px" Font-Bold="true" ID="Label26" Height="3px" Width="1200px"
                                                                                                runat="server" Text="-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                                            <br />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" Font-Size="16px" FontBold="true" ID="lblBillNo"
                                                                                                Height="20px" Font-Bold="true" Width="100px" runat="server" Text="BillNo." />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblClientName" Font-Size="16px"
                                                                                                Font-Bold="true" runat="server" Height="20px" Width="250px" Text="ClientName" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblBillDate" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="BillDate" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblTotalAmount" Font-Size="16px"
                                                                                                Font-Bold="true" runat="server" Height="20px" Width="100px" Text="TotalAmount" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblDiscount" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="Discount" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblZone" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="Zone" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblBalance" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="Balance" />
                                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblSAPLabCode" Font-Size="16px"
                                                                                                Font-Bold="true" runat="server" Height="20px" Width="100px" Text="SAPLabCode" />
                                                                                            <%--<asp:Label Style="font-family: Trebuchet MS" ID="lblStampSign" Font-Size="16px" Font-Bold="true"
                                                                                                runat="server" Height="20px" Width="100px" Text="Stamp & Sign" />
                                                                                            <br />
                                                                                            <asp:Label Font-Size="11px" ID="Label27" Font-Bold="true" Height="15px" Width="1200px"
                                                                                                runat="server" Text="--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                                        </HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <%--<br />
                                                                                            <asp:Label ID="Label5" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("InvoiceNumber") %>' />
                                                                                            <asp:Label ID="lblClientName" Font-Size="16px" Height="20px" Width="250px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("Comments") %>' />
                                                                                            <asp:Label ID="lblBillDate" Font-Size="16px"   Height="20px" Width="100px" Style="font-family: Trebuchet MS" DataFormatStrin="{0:d}"
                                                                                                runat="server" Text='<%# bind("BilledDate") %>' />
                                                                                                
                                                                                            <asp:Label ID="lblTotalAmt" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("GrossValue") %>' />
                                                                                            <asp:Label ID="lblDiscount" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("Discount") %>' />
                                                                                            <asp:Label ID="lblZone" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("ZoneCode") %>' />
                                                                                            <asp:Label ID="lblBalance" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("NetValue") %>' />
                                                                                            <asp:Label ID="lblSapLabCode" Font-Size="16px" Height="20px" Width="100px" Style="font-family: Trebuchet MS"
                                                                                                runat="server" Text='<%# bind("SaPLabCode") %>' />
                                                                                            <%--<asp:DataList ID="dlstDispatchList" runat="server">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="Label5" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("BillNo") %>' />
                                                                                        <asp:Label ID="lblClientName" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("ClientName") %>' />
                                                                                        <asp:Label ID="lblBillDate" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("BillDate") %>' />
                                                                                        <asp:Label ID="lblTotalAmt" Font-Size="16px" Height="20px" Width="250px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("TotalAmount") %>' />
                                                                                        <asp:Label ID="lblDiscount" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Discount") %>' />
                                                                                        <asp:Label ID="lblZone" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Zone") %>' />
                                                                                        <asp:Label ID="lblBalance" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("Balance") %>' />
                                                                                        <asp:Label ID="lblSapLabCode" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                                            runat="server" Text='<%# bind("SAPLabCode") %>' />
                                                                                    </ItemTemplate>
                                                                                </asp:DataList>
                                                                                        </ItemTemplate>
                                                                                    </asp:DataList>
                                                                                    <p style="page-break-before: always">
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:DataList>--%>
                                    </asp:Panel>
                                </div>
                                <table class="a-center">
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClosed()"  meta:resourcekey="btnPnlClose1Resource2"/>
                                        </td>
                                        <td class="a-center">
                                            <asp:Button ID="btndispatchSheetprint" runat="server" class="btn" Text="Print" OnClientClick="return popupprint1();" meta:resourcekey="btndispatchSheetprintResource2"/>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <cc1:ModalPopupExtender ID="InvStatusPopup" runat="server" BackgroundCssClass="modalBackground"
                                DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="btnchklistprint">
                            </cc1:ModalPopupExtender>
                        </div>
                        <div id="divAck" style="display: none;">
                            <asp:Panel ID="PnlAck" runat="server" Style="height: 420px; width: 1200px;" CssClass="modalPopup dataheaderPopup">
                                <div id="DivackChild" runat="server" style="display: block;">
                                    <asp:Panel ID="PanellAckChild" runat="server" class="AddScroll">
                                        <table class="a-center">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Label CssClass="font16 h-30" Visible="false" Style="font-family: Trebuchet MS"
                                                        ID="Label61" Font-Bold="true" Width="400px" runat="server" Text="" />
                                                    <asp:Label CssClass="font19 h-30" ID="Label7" Style="font-family: Trebuchet MS" Visible="false"
                                                        Font-Bold="true" Width="300px" runat="server" Text="ZONE WISE INVOICE REGISTER - " meta:resourcekey="Label7Resource2"/>
                                                    <asp:Label CssClass="font19 h-30" Style="font-family: Trebuchet MS" ID="Label8" Font-Bold="true"
                                                        runat="server" Text="" />
                                                    <br />
                                                    <asp:Label CssClass="font16 h-30" Style="font-family: Trebuchet MS" ID="Label9" Font-Bold="true"
                                                        Width="250px" runat="server" Text="" />
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataList ID="ZoneActList" runat="server" OnItemDataBound="ZoneActDatList_ItemDataBound">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="a-center">
                                                            <asp:Label CssClass="font19 h-30" ID="Label25" Style="font-family: Trebuchet MS"
                                                                Font-Bold="true" Width="300px" runat="server" Text="ZONE WISE BILL REGISTER - " meta:resourcekey="Label25Resource2"/>
                                                            <asp:Label CssClass="font19 h-30" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                                Font-Bold="true" runat="server" Text="" meta:resourcekey="lblprintingperiodResource2"/>
                                                            <br />
                                                            <asp:Label CssClass="font16 h-30" Style="font-family: Trebuchet MS" ID="lblPrintedAt"
                                                                Font-Bold="true" Width="250px" runat="server" Text="" />
                                                            <br />
                                                            <asp:Label CssClass="font20" Font-Bold="true" Style="page-break-before: always" ID="ZoneName"
                                                                runat="server" Text='<%# Eval("ZoneName") %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-left">
                                                            <br />
                                                            <asp:DataList ID="ClientActDataList" runat="server">
                                                                <HeaderTemplate>
                                                                    <asp:Label CssClass="font12 h-3" Font-Bold="true" ID="Label26" Width="1200px" runat="server"
                                                                        Text="-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" meta:resourcekey="Label26Resource2"/>
                                                                    <br />
                                                                    <asp:Label Style="font-family: Trebuchet MS" CssClass="font16 h-20 w-100" FontBold="true"
                                                                        ID="lblBillNo" Font-Bold="true" runat="server" Text="BillNo." meta:resourcekey="lblBillNoResource2"/>
                                                                    <asp:Label Style="font-family: Trebuchet MS" ID="lblClientName" CssClass="font16 h-20"
                                                                        Font-Bold="true" runat="server" Width="350px" Text="Party Name" meta:resourcekey="lblClientNameResource2"/>
                                                                    <asp:Label Style="font-family: Trebuchet MS" ID="lblBillDate" CssClass="font16 h-20 w-100"
                                                                        Font-Bold="true" runat="server" Text="BillDate" meta:resourcekey="lblBillDateResource2"/>
                                                                    <asp:Label Style="font-family: Trebuchet MS" ID="lblZone" CssClass="font16 h-20 w-80"
                                                                        Font-Bold="true" runat="server" Text="Zone" meta:resourcekey="lblZoneResource2"/>
                                                                    <asp:Label Style="font-family: Trebuchet MS" ID="lblSAPLabCode" CssClass="font16 h-20"
                                                                        Font-Bold="true" runat="server" Width="130px" Text="SAPLabCode" meta:resourcekey="lblSAPLabCodeResource2"/>
                                                                    <asp:Label Style="font-family: Trebuchet MS" ID="lblStampSign" CssClass="font16 h-20"
                                                                        Font-Bold="true" runat="server" Width="300px" Text="Stamp & Sign" meta:resourcekey="lblStampSignResource2" />
                                                                    <br />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label CssClass="font11 h-10" ID="Label11" Font-Bold="true" Width="1200px" runat="server"
                                                                        Text="--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" meta:resourcekey="Label11Resource2"/>
                                                                    <br />
                                                                    <asp:Label ID="Label10" CssClass="font16" Height="240px" Width="1px" runat="server"
                                                                        Text='' />
                                                                    <asp:Label ID="Label5" CssClass="font16 w-100" Height="240px" Style="font-family: Trebuchet MS"
                                                                        runat="server" Text='<%# bind("InvoiceNumber") %>' />
                                                                    <asp:Label ID="lblClientName" CssClass="font16" Height="240px" Width="350px" Style="font-family: Trebuchet MS"
                                                                        runat="server" Text='<%# bind("Comments") %>' />
                                                                    <asp:Label ID="lblBillDate" CssClass="font16 w-100" Height="240px" Style="font-family: Trebuchet MS"
                                                                        DataFormatStrin="{0:d}" runat="server" Text='<%# bind("BilledDate") %>' />
                                                                    <asp:Label ID="lblZone" CssClass="font16 w-80" Height="240px" Style="font-family: Trebuchet MS"
                                                                        runat="server" Text='<%# bind("ZoneCode") %>' />
                                                                    <asp:Label ID="lblSapLabCode" CssClass="font16" Height="240px" Width="130px" Style="font-family: Trebuchet MS"
                                                                        runat="server" Text='<%# bind("SaPLabCode") %>' />
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <p style="page-break-before: always">
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </asp:Panel>
                                </div>
                                <table class="a-center">
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btncloseAct" runat="server" class="btn" Text="Close" OnClientClick="return popupClosedAct()" meta:resourcekey="btncloseActResource2"/>
                                        </td>
                                        <td class="a-center">
                                            <asp:Button ID="btnAckprint" runat="server" class="btn" Text="Print" OnClientClick="return popupprint1Act();" meta:resourcekey="btnAckprintResource3"/>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <cc1:ModalPopupExtender ID="ModalPopupInvoiceAct" runat="server" BackgroundCssClass="modalBackground"
                                DropShadow="false" PopupControlID="PnlAck" Enabled="True" TargetControlID="btnActprint">
                            </cc1:ModalPopupExtender>
                        </div>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                                    <ajc:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                        TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                        CancelControlID="btnCnl">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlAttrib" Style="display: none;" BorderWidth="1px" Height="95%" CssClass="modalPopup dataheaderPopup w-77p"
                                        runat="server">
                                        <table class="w-100p h-100p">
                                            <tr>
                                                <td class="a-right v-top">
                                                    &nbsp;<asp:DropDownList ID="drpreportformat" runat="server" CssClass="ddlsmall" meta:resourcekey="drpreportformatResource1"
                                                        OnSelectedIndexChanged="drpreportformat_SelectedIndexChanged" AutoPostBack="True">
                                                    </asp:DropDownList>
                                                    <asp:Label ID="lblmsg" runat="server" ForeColor="#990000" Font-Bold="True"></asp:Label>
                                                    &nbsp;&nbsp;<asp:TextBox ID="txtClientEmail" runat="server" AutoCompleteType="Disabled"
                                                        CssClass="small"></asp:TextBox>
                                                    &nbsp;<asp:Button ID="btnSendEmail" runat="server" Text="Send Email" CssClass="btn"
                                                        OnClick="btnSendEmail_Click" OnClientClick="javascript:return checkEmail();" meta:resourcekey="btnSendEmailResource3"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="v-top">
                                                    <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote">
                                                        <ServerReport ReportServerUrl="" />
                                                    </rsweb:ReportViewer>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:popupClosed();" meta:resourcekey="btnCnlResource3"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                        <table>
                        <tr>
                <td class="a-center" id="tdTRF" runat="server">
                   <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                        vertical-align: bottom; top: 80px;" meta:resourcekey="pnlOthersResource1">
                                        <table class="w-100p a-center">
                                            <tr>
                                                <td class="a-right">
                                                    <img class="w-29 h-30 pointer" src="../Images/Close_Red_Online_small.png" alt="Close"
                                                        id="img2" onclick="ClosePopUp()" style="position: absolute; top: -8px; right: 10px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <iframe id="ifInvoiveImage" runat="server" width="1000" height="550"></iframe>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                     <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                        BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                    </ajc:ModalPopupExtender>
                </td>
            </tr>
                        </table>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
                        <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                        <asp:HiddenField ID="hdnInvID" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnChkInvoice" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                        <input type="hidden" id="hdnHubID" runat="server" value="0" />
                        <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
						 <input type="hidden" id="hdnInvoiceType" runat="server" />
						 <input type="hidden" runat="server" id="hdnInvoiceMultiplePayment" value="0"/>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
