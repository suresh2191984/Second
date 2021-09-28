<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreditDebitOutstandingHistory.aspx.cs"
    Inherits="Ledger_CreditDebitOutstandingResult" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<script type="text/javascript" src="../Scripts_New/jquery.dataTables.min.js"></script>--%>
​<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Detailed History</title>
    <style type="text/css">
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
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
        table.dataTable tbody tr.selected
        {
            background-color: #B0BED9;
        }
        table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover
        {
            background-color: #FFFF77;
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

    <%--  <link rel="stylesheet" type="text/css" href="../StyleSheets_New/jquery.dataTables.css" />--%>
</head>
<body onload="GetData();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="updhistory" runat="server">
        <ContentTemplate>
            <div class="contentdata" style="text-align: center">
                <table class="searchPanel">
                    <tr>
                        <td class="w-100p a-center bold" height="23" align="center">
                            <asp:Label runat="server" ID="lblheaderCredit" Text="Credit Details - " Style="display: none"></asp:Label>
                            <asp:Label runat="server" ID="lblValueCredit" Font-Bold="true" Style="display: none"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table class="w-100p">
                    <tr>
                        <td class="w-5p">
                        </td>
                        <td>
                            <div id="show" runat="server">
                                <table id="tblCreditresult" style="display: none" class="display">
                                    <thead>
                                        <tr>
                                            <th align="center" height="25px">
                                                Credit Date
                                            </th>
                                            <th align="center" height="25px">
                                                Source Code
                                            </th>
                                            <th align="center" height="25px">
                                                Narration
                                            </th>
                                            <th align="center" height="25px">
                                                BarCode
                                            </th>
                                            <th align="center" height="25px">
                                                Amount
                                            </th>
                                            <th align="center" height="25px">
                                                Remarks
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td class="w-5p">
                        </td>
                    </tr>
                    <tr>
                        <td class="w-5p">
                        </td>
                        <td>
                            <div id="divdebitshow" runat="server">
                                <asp:Label runat="server" ID="lblHederDebit" Text="Debit Details - " Style="display: none"></asp:Label>
                                <asp:Label runat="server" ID="lblDebitClientValue" Font-Bold="true" Style="display: none"></asp:Label>
                                <table id="tblDebitresult" style="display: none" class="display">
                                    <thead>
                                        <tr>
                                            <th align="center" height="25px">
                                                Debit Date
                                            </th>
                                            <th align="center" height="25px">
                                                Source Code
                                            </th>
                                            <th align="center" height="25px">
                                                Narration
                                            </th>
                                            <th align="center" height="25px">
                                                BarCode
                                            </th>
                                            <th align="center" height="25px">
                                                Amount
                                            </th>
                                            <th align="center" height="25px">
                                                Remarks
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td class="w-5p">
                        </td>
                    </tr>
                    <tr>
                        <td class="w-5p">
                        </td>
                        <td>
                            <div id="divBillshow" runat="server">
                                <asp:Label runat="server" ID="lblHdnBill" Text="Bill Details - " Style="display: none"></asp:Label>
                                <asp:Label runat="server" ID="lblBillValue" Font-Bold="true" Style="display: none"></asp:Label>
                                <table id="tblBillDetails" style="display: none" class="display">
                                    <thead>
                                        <tr>
                                            <th align="center" height="25px">
                                                Bill Date
                                            </th>
                                            <th align="center" height="25px">
                                                Patient Details
                                            </th>
                                            <th align="center" height="25px">
                                                Source Code
                                            </th>
                                            <th align="center" height="25px">
                                                Amount
                                            </th>
                                            <th align="center" height="25px">
                                                Remarks
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td class="w-5p">
                        </td>
                    </tr>
                    <tr>
                        <td class="w-5p">
                        </td>
                        <td>
                            <div id="divReceipts" runat="server">
                                <asp:Label runat="server" ID="lblhdnRecipt" Text="Receipt Details - " Style="display: none"></asp:Label>
                                <asp:Label runat="server" ID="lblReciptValue" Font-Bold="true" Style="display: none"></asp:Label>
                                <table id="tblReceiptsDetails" style="display: none" class="display">
                                    <thead>
                                        <tr>
                                            <th align="center" height="25px">
                                                Receipt Date
                                            </th>
                                            <th align="center" height="25px">
                                                Source Code
                                            </th>
                                            <th align="center" height="25px">
                                                Payment Mode
                                            </th>
                                            <th align="center" height="25px">
                                                Amount
                                            </th>
                                            <th align="center" height="25px">
                                                Response Code
                                            </th>
                                            <th align="center" height="25px">
                                                Response Msg
                                            </th>
                                            <th align="center" height="25px">
                                                TxnId
                                            </th>
                                            <th align="center" height="25px">
                                                Transaction Status
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td class="w-5p">
                        </td>
                    </tr>
                </table>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Button ID="btnback" runat="server" TabIndex="4" Text="Back to Home" CssClass="btn"
                                meta:resourcekey="btnChangeResource2" OnClick="btnback_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    <asp:HiddenField ID="hdnOrgid" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">




    $(document).ready(

    function GetData() {
        debugger;
        try {
            var Clientcode = GetQueryStringParams('CID');
            var Type = GetQueryStringParams('TYPE');
            // var regExp = /\(([^)]+)\)/;
            //   var arr = regExp.exec(ClientName);
            //  var Clientcode = arr[1];
            var orgid = document.getElementById('hdnOrgid').value;
            if (Type == 'CREDIT') {
                $('#lblheaderCredit').show();
                $('#lblValueCredit').show();
                document.getElementById('lblValueCredit').innerHTML = Clientcode;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetCreditHistory",
                    contentType: "application/json;charset=utf-8",
                    data: "{'clientcode':'" + Clientcode + "','orgid':'" + orgid + "'}",
                    dataType: "json",
                    async: false,
                    success: CreditDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#tblCreditresult').hide();
                        return false;
                    }
                });
                $('#tblCreditresult').show();
            }
            if (Type == 'DEBIT') {
                $('#lblHederDebit').show();
                $('#lblDebitClientValue').show();
                document.getElementById('lblDebitClientValue').innerHTML = Clientcode;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetDebitHistory",
                    contentType: "application/json;charset=utf-8",
                    data: "{'clientcode':'" + Clientcode + "','orgid':'" + orgid + "'}",
                    dataType: "json",
                    async: false,
                    success: DebitDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#tblDebitresult').hide();
                        return false;
                    }
                });
                $('#tblDebitresult').show();
            }
            if (Type == 'BILL') {
                $('#lblHdnBill').show();
                $('#lblBillValue').show();
                document.getElementById('lblBillValue').innerHTML = Clientcode;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetBillsHistory",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify({ clientcode: Clientcode, orgid: orgid }),
                    dataType: "json",
                    async: false,
                    success: BillDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#tblBillDetails').hide();
                        return false;
                    }
                });
                $('#tblBillDetails').show();

            }
            if (Type == 'RECEIPT') {
                $('#lblhdnRecipt').show();
                $('#lblReciptValue').show();
                document.getElementById('lblReciptValue').innerHTML = Clientcode;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetReceiptHistory",
                    contentType: "application/json;charset=utf-8",
                    data: "{'clientcode':'" + Clientcode + "','orgid':'" + orgid + "'}",
                    dataType: "json",
                    async: false,
                    success: ReceiptDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#tblReceiptsDetails').hide();
                        return false;
                    }
                });
                $('#tblReceiptsDetails').show();
            }
        }
        catch (e) {
        }
        return false
    }
    );


    function CreditDataSucceeded(result) {

        try {
            debugger;
            var oTable;
            if (result != "[]") {
                oTable = $('#tblCreditresult').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
            { "mDataProp": "SubSourceCode", sClass: "w-10p a-left" },
            { "mDataProp": "SourceCode", sClass: "w-10p a-left" },
            { "mDataProp": "Narration", sClass: "w-10p a-left" },
            { "mDataProp": "BarCode", sClass: "w-10p a-left" },
            { "mDataProp": "Amount", sClass: "w-10p a-right" },
            { "mDataProp": "Remarks", sClass: "w-10p a-left" }
            ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[8, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 10,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                          "copy", "csv", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
                                            }
                                       ]
                    }
                });
                $('#tblCreditresult').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data credits');
        }

        return false;
    }
    function DebitDataSucceeded(result) {

        try {
            debugger;
            var oTable;
            if (result != "[]") {
                oTable = $('#tblDebitresult').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [

            { "mDataProp": "SubSourceCode", sClass: "w-10p a-left" },
            { "mDataProp": "SourceCode", sClass: "w-10p a-left" },
            { "mDataProp": "Narration", sClass: "w-10p a-left" },
            { "mDataProp": "BarCode", sClass: "w-10p a-left" },
            { "mDataProp": "Amount", sClass: "w-10p a-right" },
            { "mDataProp": "Remarks", sClass: "w-10p a-left"}],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[8, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 10,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                          "copy", "csv", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
                                            }
                                       ]
                    }
                });
                $('#tblDebitresult').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data for debits');
        }

        return false;
    }
    function BillDataSucceeded(result) {

        try {
            debugger;
            var oTable;
            if (result != "[]") {
                oTable = $('#tblBillDetails').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [

            { "mDataProp": "SubSourceCode", sClass: "w-10p a-left" },
             { "mDataProp": "Status", sClass: "w-30p a-left" },
            { "mDataProp": "SourceCode", sClass: "w-15p a-left" },
            { "mDataProp": "Amount", sClass: "w-10p a-right" },
            { "mDataProp": "Remarks", sClass: "w-40p a-left"}],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[8, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 10,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                          "copy", "csv", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
                                            }
                                       ]
                    }
                });
                $('#tblBillDetails').show();
            }
        }
        catch (e) {
            alert('Exception while binding bills Data ');
        }

        return false;
    }
    function ReceiptDataSucceeded(result) {

        try {
            debugger;
            var oTable;
            if (result != "[]") {
                oTable = $('#tblReceiptsDetails').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [

            { "mDataProp": "SubSourceCode", sClass: "w-5p a-left" },
            { "mDataProp": "SourceCode", sClass: "w-10p a-left" },
            { "mDataProp": "Mode", sClass: "w-10p a-left" },
            { "mDataProp": "Amount", sClass: "w-8p a-right" },
            { "mData": "Remarks", sClass: "w-5p a-center", "mRender": function(data, type, full) { //Response Code
                var ResponseArr = data.split(',');
                var ResultValue = ResponseArr[0].split(':');
                if (ResultValue[1] == 0) {
                    return '<label style="color:green; font-weight: bold;" >' + ResultValue[1] + '</label>';
                }
                return '<label style="color: red ; font-weight: bold;" >' + ResultValue[1] + '</label>';

            }
            },
            { "mData": "Remarks", sClass: "w-10p a-left", "mRender": function(data, type, full) { //Response Message
                var ResponseArr = data.split(',');
                var ResultValue = ResponseArr[1].split(':');
                return '<label>' + ResultValue[1] + '</label>';
            }
            },
         { "mData": "Remarks", sClass: "w-10p a-left", "mRender": function(data, type, full) {// TxnID
             var ResponseArr = data.split(',');
             var ResultValue = ResponseArr[2].split(':');
             return '<label>' + ResultValue[1] + '</label>';
         }
         },
         { "mData": "Remarks", sClass: "w-5p a-center", "mRender": function(data, type, full) { //TxnStatus
             var ResponseArr = data.split(',');
             var ResultValue = ResponseArr[0].split(':');
             if (ResultValue[1] == 0) {
                 return '<label style="color:green ; font-weight: bold;" >SUCCESS</label>';
             }
             return '<label style="color: red ; font-weight: bold;" >FAILURE</label>';

         } }],
                    "aaSorting": [],
                    "order": [],
                    "sPaginationType": "full_numbers",
                    //"aaSorting": [[8, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 10,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                          "copy", "csv", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
                                            }
                                       ]
                    }
                });
                $('#tblReceiptsDetails').show();

            }
        }
        catch (e) {
            alert('Exception while binding Data for receipt');
        }

        return false;
    }



    function GetQueryStringParams(sParam) {
        var sPageURL = window.location.search.substring(1);
        var sURLVariables = sPageURL.split('&');
        for (var i = 0; i < sURLVariables.length; i++) {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam) {
                return sParameterName[1];
            }
        }
    }
   

</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

