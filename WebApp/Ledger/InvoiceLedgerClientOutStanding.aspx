<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceLedgerClientOutStanding.aspx.cs"
    Inherits="Ledger_InvoiceLedgerClientOutStanding" EnableEventValidation="false" %>

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
                                        <table id="tblOutstanding" style="display: none" class="w-100p display" cellpadding="0px"
                                            cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th align="center">
                                                        Client Name
                                                    </th>
                                                      <th align="center">
                                                       Total Pending Amount
                                                    </th>
                                                     <th align="center" valign="bottom">
                                                       <%--<asp:Label ID="lblm1" runat="server"></asp:Label>--%>
                                                       <label id="lblm1" runat="server"></label>
                                                    </th>
                                                    <th align="center" valign="bottom">
                                                        <%--<asp:Label ID="lblm2" runat="server"></asp:Label>--%>
                                                        <label id="lblm2" runat="server"></label>
                                                    </th>
                                                    <th align="center" valign="bottom">
                                                        <%--<asp:Label ID="lblm3" runat="server"></asp:Label>--%>
                                                        <label id="lblm3" runat="server"></label>
                                                    </th>
                                                    <th align="center" valign="bottom">
                                                        <%--<asp:Label ID="lblm4" runat="server"></asp:Label>--%>
                                                        <label id="lblm4" runat="server"></label>
                                                    </th>
                                                    <th align="center" valign="bottom">
                                                        <%--<asp:Label ID="lblm5" runat="server"></asp:Label>--%>
                                                         <label id="lblm5" runat="server"></label>
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
                url: "../WebService.asmx/InvoiceClientOutstanding",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'ClientID':'" + ClientID + "'}",
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
                    "aoColumns":
                    [
                         { "mDataProp": "ClientName", sClass: "w-25p a-left" },
                         //{ "mDataProp": "TotalPending", sClass: "w-15p a-right" },
                         { "mData": "TotalPending", sClass: "w-15p a-right", "mRender": function(data, type, full) {
                             return '<span id="spnMethodName' + full.ClientId + '" style="color: Red;">' + data + '</span>'
                         } 
                         },

                     { "mData": "M1Pending", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                         return '<a href="../Ledger/InvoiceLedgerOutStandingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '&MID=M1">' + data + '</a>';

                     }
                     },
                     { "mData": "M2Pending", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                         return '<a href="../Ledger/InvoiceLedgerOutStandingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '&MID=M2">' + data + '</a>';
                     }
                     },
                { "mData": "M3Pending", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                    return '<a href="../Ledger/InvoiceLedgerOutStandingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '&MID=M3">' + data + '</a>';
                }
                },
                { "mData": "M4Pending", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                    return '<a href="../Ledger/InvoiceLedgerOutStandingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '&MID=M4">' + data + '</a>';
                }
                },
                { "mData": "TotalAmt", sClass: "w-10p a-right", "mRender": function(data, type, full) {
                    return '<a href="../Ledger/InvoiceLedgerOutStandingDetails.aspx?CID=' + full.ClientId + '&CODE=' + full.ClientCode + '&MID=M5">' + data + '</a>';
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

    function ClearData() {
        debugger;
        if (document.getElementById('hdnCID').value != '') {

        }
        //GetClientData();
        GetData();
        return false;
    }
    
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

