<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceLedgerClosingBills.aspx.cs"
    Inherits="Ledger_InvoiceLedgerClosingBills" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice Ledger Client OutStanding</title>
    <style type="text/css">
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
        table.dataTable tbody tr.selected
        {
            background-color: #B0BED9;
        }
        table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover
        {
            background-color: #FFFF77;
        }
        th
        {
            text-align: "center";
        }
    </style>
    <%--<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />--%>
    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="pnlUpdate" runat="server">
        <ContentTemplate>
            <div class="contentdata" style="text-align: center">
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor w-100p">
                                <table class="w-100p searchPanel">
                                    <tr class="panelHeader">
                                        <td class="colorforcontent w-100p" height="23" align="center">
                                            <asp:Label ID="Rs_FilterResult2" runat="server" Text="Invoice Ledger Client OutStanding" meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="w-100p">
                                                <table class="w-80p a-center ">
                                                    <tr class="a-center">
                                                        <td class="w-20p">
                                                        </td>
                                                        <td class="a-center">
                                                            <asp:HiddenField ID="hdnClientID" runat="server" />
                                                            <asp:Label ID="lblClientName" Font-Bold="true" Text="Client Name/Code" runat="server"></asp:Label>
                                                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                                                                OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                OnClientItemOver="SelectedOver" Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                            <asp:Button ID="btnSearch" runat="server" TabIndex="4" Text="Search" CssClass="btn"
                                                                meta:resourcekey="btnChangeResource2" OnClientClick="javascript:return GetData();" />
                                                            <asp:Button ID="btnreset" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                                                                meta:resourcekey="btnChangeResource2" OnClientClick="javascript:return ClearData();" />
                                                        </td>
                                                    </tr>
                                                      <tr><td></td></tr>
                                                    <tr>
                                                        <td align="center">
                                                            
                                                        </td>
                                                        <td align="center">
                                                        <asp:Label ID="Label1" Font-Bold="true" Font-Size="Large" Text="ClientName :" runat="server"></asp:Label>
                                                            <asp:Label ID="lblClientName1" Font-Bold="true" Font-Size="Large"  runat="server"></asp:Label>
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
                </table>
                <table class="w-100p">
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="w-1p">
                        </td>
                        <td class="a-center">
                            <asp:UpdatePanel ID="updatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="divdebitshow" runat="server" class="center">
                                        <table id="tblOutstanding" style="display: none" class="w-80p display" cellpadding="0px"
                                            cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <%--<th align="center" height="25px">
                                                        Client Code
                                                    </th>--%>
                                                    <th align="center" height="25px">
                                                        ClientName
                                                    </th>
                                                    <th align="center" height="25px">
                                                        BillDate
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Patient Name
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Bill Amount
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Paid Status
                                                    </th>
                                                 
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <table class="w-80p display" cellpadding="0px">
                                    <tr>
                                    <td align="center"><asp:Button ID="btnhome" CssClass="btn" runat="server" Text="Back" OnClientClick="javascript:return FunHome();" /></td>
                                    </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td class="w-1p">
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnclientType" runat="server" />
    <asp:HiddenField ID="hdnCID" runat="server" />
    <asp:HiddenField ID="ClientID" runat="server" />
    </form>
</body>

<script type="text/javascript">
    $(document).ready(function() {
        debugger;
        GetData();
        $(function() {
            $('body').contents().eq(0).each(function() {
                if (this.nodeName.toString() == '#text' && this.data.trim().charCodeAt(0) == 8203) {
                    $(this).remove();
                }
            });
        });
    });

    function GetData() {
        debugger;
        document.getElementById('ClientID').value = "";
        var InvoiveId = "";
        InvoiveId = GetQueryStringParams('INVOICEID');
        var ClientID = "";
        ClientID = GetQueryStringParams('CID');
        document.getElementById('ClientID').value = ClientID;
        ClientCode = GetQueryStringParams('CODE');
        document.getElementById('lblClientName1').innerHTML = ClientCode;
        var OrgID = document.getElementById('hdnOrgID').value;

        if (ClientID != "" && InvoiveId != "") {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetLedgerInvoiceOutstandingBills",
                contentType: "application/json;charset=utf-8",
                data: "{'ClientID':" + ClientID + ",'InvoiveId':" + InvoiveId + ",'OrgID':" + OrgID + "}",
                // data: "{'ClientID':70,'InvoiveId':499,'OrgID':70}",
                dataType: "json",
                async: false,
                success: OutstandingDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    debugger;
                    alert("Error");
                    $('#tblOutstanding').hide();
                    return false;
                }
            });
            $('#tblOutstanding').show();
        }
        else {
            alert('Error While Loading Data');
            return false;
        }
        function OutstandingDataSucceeded(result) {
            try {
                debugger;
                var oTable;
                if (result != "[]") {
                    oTable = $('#tblOutstanding').dataTable({

                        "bDestroy": true,
                        "bAutoWidth": false,
                        "bProcessing": true,
                        //"serverSide": true,
                        "aaData": result.d,
                        "sEmptyTable": { "sEmptyTable": "No matching record" },
                        "aoColumns": [
                    { "mDataProp": "ClientName", sClass: "w-6p a-left" },
                    { "mDataProp": "FromDate", sClass: "w-2p a-left" },
                    { "mDataProp": "Name", sClass: "w-5p a-left" },
                    { "mDataProp": "Amount", sClass: "w-1p a-right" },
                        //{ "mDataProp": "Status", sClass: "w-2p a-center" },
                       {"mData": "Status", sClass: "w-1p a-center", "mRender": function(data, type, full) {
                        if (full.Status == 'Approved') {

                            return '<span id="spnMethodName' + full.ClientId + '" style="font-weight: bold;color: green;">' + data + '</span>'
                        }
                        else if (full.Status == 'Pending') {

                            return '<span id="spnMethodName1' + full.ClientId + '" style="font-weight: bold;color: NavyBlue;">' + data + '</span>'
                        }
                        else if (full.Status == 'Rejected' || full.Status=='Not Paid') {

                            return '<span id="spnMethodName2' + full.ClientId + '" style="font-weight: bold;color: Red;">' + data + '</span>'
                        }
                        else
                        {

                            return '<span id="spnMethodName3' + full.ClientId + '" style="font-weight: bold;color: NavyBlue;">' + data + '</span>'
                        }
                    }
}],

                        "sPaginationType": "full_numbers",
                        "aaSorting": [],
                        //"bSort": false,
                        "bJQueryUI": true,
                        "iDisplayLength": 10,
                        //                    "sScrollY": "270px",
                        //                    "sScrollXInner": "100%",
                        //                    "bScrollCollapse": true,
                        //                    "bPaginate": false,
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            "aButtons": [
                                          "copy", "xls", "pdf",
                                            {
                                                "sExtends": "collection",
                                                "sButtonText": "Save",
                                                "aButtons": ["csv", "xls", "pdf"]
}]
                        }

                    });
                    $('#tblOutstanding').show();
                }
            }
            catch (e) {
                alert('Exception while binding Data for receipt');
                return false;
            }
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
    }
    function FunHome() {
        debugger;
        var id = '';
        id = document.getElementById('ClientID').value;
        var code = '';
        code = document.getElementById('lblClientName1').innerHTML;
        window.location.replace("../Ledger/InvoiceLedgerClosingDetails.aspx?CID=" + id + "&CODE=" + code + "");
        
    }
</script>

</html>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

