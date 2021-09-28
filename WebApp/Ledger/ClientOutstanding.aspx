<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientOutstanding.aspx.cs"
    Inherits="Ledger_ClientOutstanding" EnableEventValidation="false" %>

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

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

​

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Client OutStanding</title>
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
                                            <asp:Label ID="Rs_FilterResult2" runat="server" Text="Client Outstanding" meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
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
                        <td class="w-8p">
                        </td>
                        <td class="a-center">
                            <asp:UpdatePanel ID="updatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="divdebitshow" runat="server">
                                        <table id="tblOutstanding" style="display: none" class="w-80p display" cellpadding="0px"
                                            cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th align="center" height="25px">
                                                        Client Name
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Opening Balance
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Bills
                                                    </th>
                                                    <th align="center" height="25px"">
                                                        Debit
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Credit
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Receipt
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Outstanding
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td class="w-8p">
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
    </form>
</body>

<script>
    $(document).ready(function() {
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
        try {

            var ClientName = document.getElementById('txtClientName').value;
            var ClientCode = '';
            if (ClientName != '') {
                var regExp = /\(([^)]+)\)/;
                var arr = regExp.exec(ClientName);
                ClientCode = arr[1];
            }
            var OrgID = document.getElementById('hdnOrgID').value;

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetClientOutstanding",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'ClientCode':'" + ClientCode + "'}",
                dataType: "json",
                async: false,
                success: OutstandingDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#tblOutstanding').hide();
                    return false;
                }
            });
            $('#tblOutstanding').show();
        } catch (e) { }
        return false
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
               { "mDataProp": "ClientCode", sClass: "w-10p a-left" },
               { "mDataProp": "OpeningBalance", sClass: "w-10p a-right" },
               { "mData": "Bill", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                   return '<a href="../Ledger/CreditDebitOutstandingHistory.aspx?CID=' + full.ClientCode + '&TYPE=BILL">' + data + '</a>';
               }
               },
               { "mData": "Debit", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                   return '<a href="../Ledger/CreditDebitOutstandingHistory.aspx?CID=' + full.ClientCode + '&TYPE=DEBIT">' + data + '</a>';
               }
               },
               { "mData": "Credit", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                   return '<a href="../Ledger/CreditDebitOutstandingHistory.aspx?CID=' + full.ClientCode + '&TYPE=CREDIT">' + data + '</a>';
               }
               },
                { "mData": "Receipt", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                    return '<a href="../Ledger/CreditDebitOutstandingHistory.aspx?CID=' + full.ClientCode + '&TYPE=RECEIPT">' + data + '</a>';
                }
                },

                { "mData": "OutStanding", sClass: "w-10p a-right"}],
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
                                            }
                                                ]
                    }


                });
                $('#tblOutstanding').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data for receipt');
        }

        return false;
    }

   
   
           

</script>

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
    function ClearData() {
        debugger;
        if (document.getElementById('hdnCID').value != '') {
            document.getElementById('<%=hdnClientID.ClientID %>').value = "";
        }
        GetClientData();
        GetData();
        return false;
    }
    //Cleint List for Autocomplete
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
            if (result != "") {
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
                    if (document.getElementById('txtClientName').value == "" || document.getElementById('txtClientName').value == ClientValues[1]) {
                        document.getElementById('hdnSelectedClientClientID').Value = ClientValues[5];
                    }
                    $("#txtClientName").prop('disabled', true);
                    return false;

                }
            }
        }
        catch (e) {
            alert('Exception while Creation of Payment Session data');
        }
    }

    
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

