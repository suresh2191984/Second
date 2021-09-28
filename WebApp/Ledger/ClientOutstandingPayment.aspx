<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientOutstandingPayment.aspx.cs"
    Inherits="Ledger_ClientOutstandingPayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>

<%-- <%@ Register Src="../CommonControls_NewUI/TSPClientCurrentLedgerStatus.ascx" TagName="TSPLedger"
    TagPrefix="uc3" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
         
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
        .button-link
        {
            background-color: transparent;
            border: none;
        }
        .button-link:hover
        {
            color: blue;
            text-decoration: underline;
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

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="pnlup" runat="server">
        <ContentTemplate>
            <div class="contentdata" style="text-align: center">
                <table width="100%" class="searchPanel">
                    <tr>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 80%">
                            <div class="a-center w-90p" id="DivLpwd" runat="server">
                                <table class="w-100p a-center">
                                    <tr>
                                        <td colspan="2" class="w-100p bold a-center padding5 header-color">
                                            CLIENT JOURNAL LEDGER
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
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
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td width="5%">
                        </td>
                        <td width="90%">
                            <div id="divPrint" runat="server">
                                <table id="example" style="display: none;" class="display">
                                    <thead>
                                        <tr style="vertical-align: middle; text-align: center">
                                            <th align="center" class="w-2p" height="25px">
                                            </th>
                                            <th align="center" class="w-33p" height="25px">
                                                Client Name
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                Opening Balance
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                Bills
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                Debit
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                Credit
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                Receipt
                                            </th>
                                            <th align="center" class="w-10p" height="25px">
                                                OutStanding
                                            </th>
                                            <th align="center" class="w-5p" height="25px">
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td width="5%">
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnclientType" runat="server" />
    <asp:HiddenField ID="hdnCID" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
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
        var list = eventArgs.get_value().split('^');
        document.getElementById('<%=hdnClientID.ClientID %>').value = list[3];
    }

    /* json Datatable modification */

    $(document).ready(function() {
        GetClientData();
        GetData();
    });
    function GetData() {
        try {
            debugger;
            var ClientCode = '';
            var OrgID = '';
            var client = document.getElementById('txtClientName').value;
            if (client == "" && document.getElementById('hdnCID').value == "")
            {
                document.getElementById('hdnClientID').value = "";
            }
            ClientCode = document.getElementById('hdnClientID').value;
            OrgID = document.getElementById('hdnOrgID').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetClientOutstanding",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'ClientCode':'" + ClientCode + "'}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#example').hide();
                    return false;
                }
            });
            $('#example').show();
        }
        catch (e) {
        }
        return false
    }

        function AjaxGetFieldDataSucceeded(result) {
            try {
                var oTable;
                if (result != "[]") {
                    oTable = $('#example').dataTable({
                        "bJQueryUI": true,
                        "bDestroy": true,
                        "bAutoWidth": false,
                        "bProcessing": true,
                        //"serverSide": true,
                        "aaData": result.d,
                        "sEmptyTable": { "sEmptyTable": "No matching record" },
                        "aoColumnDefs": [{ "bSortable": false, "aTargets": [8]}],
                        //"fnStandingRedraw": function() { pop.show(); },
                        "aoColumns": [
                          { "mDataProp": "ClientCode", "bVisible": false },
                          { "mDataProp": "ClientName", sClass: "a-left" },
                          { "mDataProp": "OpeningBalance", sClass: "a-right" },
                          { "mDataProp": "Bill", sClass: "a-right" },
                          { "mDataProp": "Debit", sClass: "a-right" },
                          { "mDataProp": "Credit", sClass: "a-right" },
                          { "mDataProp": "Receipt", sClass: "a-right" },
                          { "mDataProp": "OutStanding", sClass: "a-right" },
                          { "mDataProp": "ClientCode", //Release
                              "mRender": function(data, type, full) {
                                  if (data != '') {
                                      //return '<input type="button" value="Pay" id="btnPayClient_' + data + '" Style="cursor: pointer" onclick="javascript:return ChangeReleaseCheckbox(this.id)">'
                                      return '<a href=' + data + ' Style="cursor: pointer" id=' + data + ' onClick="javascript:return selectClient(' + data + ')">Pay</a>';
                                      //return '<input type="button" value="Pay" Style="cursor: pointer" id="btnPayClientss" runat="server" onClick="selectClient_onClick"/>';
                                  }
                              } }],
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
                    $('#example').show();
                }
            }
            catch (e) {
                alert('Exception while binding Data');
            }

            return false;
        }
        function selectClient(data) 
        {
            var clientcode = '';
            var Amount = '';
            clientcode = data.id;
            Amount = $("#" + data.id).parent().parent().find('td').eq(6).text();
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/CreateClientOutstandingPayLinkSession",
                    contentType: "application/json;charset=utf-8",
                    data: "{'ClientCode':'" + clientcode + "','Amount':'" + Amount + "'}",
                    dataType: "json",
                    async: false,
                    success: AjaxGetPaySessionCreation,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        return false;
                    }
                });
                $('#example').show();
            }
            catch (e) 
            {
                alert('Exception while Creation of Payment Session');
            }
            return false;
        }
        function AjaxGetPaySessionCreation(result) {
            try {
                if (result.d == "Success") {
                    var orgid = '';
                    orgid = document.getElementById('hdnOrgID').value;
                    if (orgid == "75") {
                        //window.open("../Payment/Payment.aspx");
                        window.location.href = "../Payment/Payment.aspx";
                        return true;
                    }
                    else if (orgid == "70") {
                    //window.open("../Payment/CrediMaxPayment.aspx");
                    window.location.href = "../Payment/CrediMaxPayment.aspx";
                    return true;
                    }
                }
            }
            catch (e) {
                alert('Exception while Creation of Payment Session data');
            }
        }
        function ClearData() {
            if (document.getElementById('hdnCID').value != '') {
                document.getElementById('<%=hdnClientID.ClientID %>').value = "";
            }
            GetClientData();
            GetData();
            return false;
        }

        function GetClientData() {
            try {
                debugger;
                var ClientType = '';
                var OrgID = '';
                var ClientId = '';
                ClientId = document.getElementById('hdnCID').value;
                OrgID = document.getElementById('hdnOrgID').value;
                ClientType = document.getElementById('hdnclientType').value;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/LoadDefaultClientNameBasedOnOrgLocation",
                    contentType: "application/json;charset=utf-8",
                    data: "{'pType':'" + ClientType + "','OrgID':" + OrgID + ",'refhospid':" + ClientId + "}",
                    dataType: "json",
                    async: false,
                    success: AjaxGetClientDetailsSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        return false;
                    }
                });
            }
            catch (e) {
            }
            return false
        }
        function AjaxGetClientDetailsSucceeded(result) {
            try {
                debugger;
                if (result != "") 
                {
                    var orgid = '';
                    var ClientValues = result.d[0].Value.split('^');
                    orgid = document.getElementById('hdnOrgID').value;
                    var Type = document.getElementById('hdnclientType').value;
                    document.getElementById('<%=hdnClientID.ClientID %>').value = '';
                    if (Type == "CLP") {
                        if (hdnDefaultClienID != null) {
                            document.getElementById('hdnDefaultClienID').value = ClientValues[5];
                            document.getElementById('<%=hdnClientID.ClientID %>').value = ClientValues[3];
                        }
                        if (hdnDefaultClienName != null) {
                            document.getElementById('hdnDefaultClienName').value = ClientValues[1];
                        }
                        if (document.getElementById('txtClientName').value == "") {
                            document.getElementById('txtClientName').value = ClientValues[1];
                        }
                        if (document.getElementById('txtClientName').value == "" || document.getElementById('txtClientName').value == ClientValues[1]) 
                        {
                            document.getElementById('hdnSelectedClientClientID').Value = ClientValues[5];
                        }
                        $("#txtClientName").prop('disabled', true);
                        return false;
                       
                    }
                }
            }
            catch (e)
            {
                alert('Exception while Creation of Payment Session data');
            }
        }
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

