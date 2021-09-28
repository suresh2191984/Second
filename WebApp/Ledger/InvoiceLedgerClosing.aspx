<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceLedgerClosing.aspx.cs" Inherits="Ledger_InvoiceLedgerClosing" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoice Ledger Closing</title>
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
    <%--<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />--%>
        
     <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
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
                                        <table id="tblInvoiceLedgerClosing" style="display: none" class="w-80p display" cellpadding="0px"
                                            cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th align="center" height="25px">
                                                        Client Name
                                                    </th>
                                                     <th align="center" height="25px"">
                                                       Current OutStanding
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

            // var ClientName = document.getElementById('txtClientName').value;
            var ClientID = '';
            // if (ClientName != '') {
            // var regExp = /\(([^)]+)\)/;
            // var arr = regExp.exec(ClientName);
            ClientID = document.getElementById('hdnCID').value;

            var OrgID = document.getElementById('hdnOrgID').value;

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/InvoiceLedgerClosing",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'ClientID':'" + ClientID + "'}",
                dataType: "json",
                async: false,
                success: InvoiceLedgerClosingDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#tblInvoiceLedgerClosing').hide();
                    return false;
                }
            });
            $('#tblInvoiceLedgerClosing').show();
        } catch (e) { }
        return false
    }

    function InvoiceLedgerClosingDataSucceeded(result) {

        try {
            debugger;
            var oTable;
            if (result != "[]") {
                oTable = $('#tblInvoiceLedgerClosing').dataTable({

                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    "aoColumns":
                    [
                    { "mDataProp": "ClientName", sClass: "w-20p a-left" },
                    //{ "mDataProp": "Address", sClass: "w-10p a-left" },

                     {"mData": "Amount", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                         return '<a href="../Ledger/InvoiceLedgerClosingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '">' + data + '</a>';

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
                                            }
                                                ]
                    }


                });
                $('#tblInvoiceLedgerClosing').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data for Invoice Ledger Closing');
        }

        return false;
    }

</script>

</html>

<script type="text/javascript">

    function ClearData() {
        if (document.getElementById('hdnCID').value != '') {
        }
        GetData();
        return false;
    }
    
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>
