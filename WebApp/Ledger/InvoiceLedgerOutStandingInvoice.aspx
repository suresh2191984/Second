<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceLedgerOutStandingInvoice.aspx.cs"
    Inherits="Ledger_InvoiceLedgerOutStandingInvoice" EnableEventValidation="false" %>

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
                                                            <asp:Label ID="lblFrom" Font-Bold="true" Text="From" runat="server"></asp:Label>
                                                            <asp:DropDownList runat="server" ID="ddlForm" onchange='javascript:Validate();'>
                                                                <asp:ListItem Selected="True" Value="0">0</asp:ListItem>
                                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                                <asp:ListItem Value="30">30</asp:ListItem>
                                                                <asp:ListItem Value="60">60</asp:ListItem>
                                                                <asp:ListItem Value="90">90</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:Label ID="lblTo" Font-Bold="true" Text="To" runat="server"></asp:Label>
                                                            <asp:DropDownList runat="server" ID="ddlTo" onchange='javascript:Validate();'>
                                                                <asp:ListItem Selected="True" Value="15">15</asp:ListItem>
                                                                <asp:ListItem Value="30">30</asp:ListItem>
                                                                <asp:ListItem Value="60">60</asp:ListItem>
                                                                <asp:ListItem Value="90">90</asp:ListItem>
                                                            </asp:DropDownList>
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
                                                        <asp:Label ID="lblClientName" Font-Bold="true" Font-Size="Large" Text="ClientName :" runat="server"></asp:Label>
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
                                                        Summary
                                                    </th>
                                                    <th align="center" height="25px">
                                                        DR
                                                    </th>
                                                    <th align="center" height="25px">
                                                        CR
                                                    </th>
                                                    <%--<th align="center" height="25px">
                                                        Credit
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Receipt
                                                    </th>
                                                    <th align="center" height="25px">
                                                        Outstanding
                                                    </th>--%>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <table class="w-80p display" cellpadding="0px">
                                    <tr>
                                    <td align="center"><asp:Button ID="btnhome" CssClass="btn" runat="server" Text="Home" OnClientClick="javascript:return FunHome();" /></td>
                                    </tr>
                                    </table>
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

            var ClientID = GetQueryStringParams('CID');
            var ClientCode = '';
            ClientCode = GetQueryStringParams('CODE');
            
           document.getElementById('lblClientName1').innerHTML = ClientCode;
            var OrgID = document.getElementById('hdnOrgID').value;
            var e = document.getElementById("ddlForm");
            var From = e.options[e.selectedIndex].value;
            var d = document.getElementById("ddlTo");
            var To = d.options[d.selectedIndex].value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetLedgerInvoiceOutstandingInvList",
                contentType: "application/json;charset=utf-8",
                data: "{'ClientID':" + ClientID + ",'From':" + From + ",'To':" + To + ",'OrgID':" + OrgID + "}",
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
        } catch (e) { }
        return false
    }
    function OutstandingDataSucceeded(result) {

        try {
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
               { "mData": "ClientCode", sClass: "w-10p a-left", "mRender": function(data, type, full) {
                   if (full.InvoiceId != '0') {
                       return '<a href="../Ledger/InvoiceLedgerOutStandingBills.aspx?CID=' + full.InvoiceNumber + '&INVOICEID=' + full.InvoiceId + '&CODE=' + document.getElementById('lblClientName1').innerHTML + '" onclick="javascript:return IsBilldata(' + full.InvoiceId + ');">' + data + '</a>';
                   }
                   else if (full.InvoiceId == '0') {
                   return '<a href="../Ledger/InvoiceLedgerOutStandingBills.aspx?CID=' + full.InvoiceNumber + '&INVOICEID=' + full.InvoiceId + '&CODE=' + document.getElementById('lblClientName1').innerHTML + '" onclick="javascript:return IsBilldata(' + full.InvoiceId + ');" style="font-family:Candara; font-size:large; color:Red;">' + data + '</a>';
                   }
               }
               },
                { "mData": "Age", sClass: "w-10p a-right" },
                { "mData": "Barcode", sClass: "w-10p a-right"}],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [],
                    //"bSort": false,
                    "caption": "Just simple local grid",
                    "bJQueryUI": true,
                    "iDisplayLength": 30,
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

</html>

<script type="text/javascript">

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
    function Validate() {
        var e = document.getElementById("ddlForm");
        var from = e.options[e.selectedIndex].value;
        var d = document.getElementById("ddlTo");
        var to = d.options[d.selectedIndex].value;
        if (from > to && from != to) {
            alert('FromDate should be less then Todate..!');
            document.getElementById("ddlForm").value = 0;
            document.getElementById("ddlTo").value = 15;
            return false;
        }
    }
    function FunHome() {
        window.location.replace("../Ledger/InvoiceLedgerClientOutStanding.aspx");
    }
    function IsBilldata(id) {
        debugger;
        if (id == '0') {
            alert('Please select the listed Invoice Item...!');
            return false;
        }
    }
    
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

