<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiptStatus.aspx.cs" Inherits="Ledger_ReceiptStatus"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

    <title>Receipt Status</title>

    <script type="text/javascript" language="javascript">

        function FromDateCheck() {
            if ($("#txtFrom").val() != null) {
                if ($("#txtFrom").val() != '') {
                    var obj = $("#txtFrom").val();

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
                            $("#txtFrom").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtFrom").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtFrom").val(CurrentFullDate);
                            //$("#txtFrom").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

        }


        function DateCheck() {
            //debugger;

            var varFrom = document.getElementById('txtFrom').value;
            var varTo = document.getElementById('txtTo').value;
            var fromdate, todate, dt1, dt2, mon1, mon2, yr1, yr2, date1, date2;
            var chkFrom = varFrom;
            var chkTo = varTo;
            if (document.getElementById('txtFrom').value == '') {
                alert('From date should not be empty');
                document.getElementById('txtFrom').value = '';
                document.getElementById('txtFrom').focus();
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('To date should not be empty');
                document.getElementById('txtTo').value = '';
                document.getElementById('txtTo').focus();
                return false;
            }

            fromdate = document.getElementById('txtFrom').value;
            todate = document.getElementById('txtTo').value;
            dt1 = parseInt(fromdate.substring(0, 2), 10);
            mon1 = parseInt(fromdate.substring(3, 5), 10);
            yr1 = parseInt(fromdate.substring(6, 10), 10);
            dt2 = parseInt(todate.substring(0, 2), 10);
            mon2 = parseInt(todate.substring(3, 5), 10);
            yr2 = parseInt(todate.substring(6, 10), 10);
            date1 = new Date(yr1, mon1, dt1);
            date2 = new Date(yr2, mon2, dt2);

            if (date2 <= date1) {
                alert("To date Should be greater than From date");
                document.getElementById('txtTo').value = '';
                return false;
            }

            if ($("#txtTo").val() != null) {
                if ($("#txtTo").val() != '') {
                    var obj = $("#txtTo").val();

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
                            $("#txtTo").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtTo").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtTo").val(CurrentFullDate);
                            //$("#txtTo").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

            return true;

        }

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
            //  alert(eventArgs.get_value());
            var list = eventArgs.get_value().split('^');
            document.getElementById('<%=hdnClientID.ClientID %>').value = list[3];

        }
    </script>

</head>
<body onload="GetData();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="pnlpproval" runat="server">
        <ContentTemplate>
            <div class="contentdata w-100p">
                <table class="w-100p searchPanel">
                    <tr align="center">
                        <td class="a-center">
                            <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor w-100p">
                                <table class="w-100p searchPanel">
                                    <tr class="panelHeader">
                                        <td class="colorforcontent w-100p" align="center">
                                            <asp:Label ID="Rs_FilterResult2" runat="server" Text="Filter Result For TSP Receipt Status"
                                                meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="w-100p">
                                                <table class="w-100p m-auto">
                                                    <tr class="lh30">
                                                        <td class="a-center">
                                                            <asp:Panel ID="Panel1" runat="server" meta:resourcekey="Panel1Resource4" CssClass="w-100p a-center">
                                                                <asp:Label ID="Rs_From" Text="From Date" Font-Bold="true" runat="server"></asp:Label>
                                                                <asp:TextBox runat="server" ID="txtFrom" onchange="FromDateCheck();" CssClass="datePicker"
                                                                    MaxLength="25" size="20" Width="8%"></asp:TextBox>
                                                                <asp:Label ID="Rs_To" Text="To Date" Font-Bold="true" runat="server"></asp:Label>
                                                                <asp:TextBox runat="server" ID="txtTo" onchange="DateCheck();" MaxLength="25" size="20"
                                                                    CssClass="datePicker" Width="8%"></asp:TextBox>
                                                                <asp:Label ID="lblStatus" runat="server" Text="Status" Font-Bold="true" ForeColor="Black"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterby" runat="server">
                                                                    <asp:ListItem Value="all" Text="ALL" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Value="pending" Text="Pending"></asp:ListItem>
                                                                    <asp:ListItem Value="Recommended" Text="Recommended"></asp:ListItem>
                                                                    <asp:ListItem Value="approved" Text="Approved"></asp:ListItem>
                                                                    <asp:ListItem Value="rejected" Text="Rejected"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblClientName" Text="Client Name/Code" Font-Bold="true" runat="server"></asp:Label>
                                                                <asp:HiddenField ID="hdnClientID" runat="server" />
                                                                <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="20%"></asp:TextBox>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                                                                    OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                    OnClientItemOver="SelectedOver" Enabled="True">
                                                                </cc1:AutoCompleteExtender>
                                                                <asp:Button ID="btnSearch" runat="server" TabIndex="4" Text="Search" CssClass="btn"
                                                                    OnClientClick="javascript:return GetData();" />
                                                                <asp:Button ID="btnReset" runat="server" OnClick="btnReset_click" TabIndex="4" Text="Reset"
                                                                    CssClass="btn" meta:resourcekey="btnChangeResource2" />
                                                                </asp:LinkButton>
                                                            </asp:Panel>
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
                    <tr align="center">
                        <td class="w-5p">
                        </td>
                        <td class="a-center w-90p">
                            <asp:UpdatePanel ID="updatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>
                                    <div id="show" runat="server">
                                        <table id="tblReceiptStatus" style="display: none" class="display">
                                            <thead>
                                                <tr>
                                                    <th align="center">
                                                        Date
                                                    </th>
                                                    <th align="right">
                                                        TSP
                                                    </th>
                                                    <th align="center">
                                                        Receipt No
                                                    </th>
                                                    <th align="center">
                                                        Payment Mode
                                                    </th>
                                                    <th align="center">
                                                        Payment Type
                                                    </th>
                                                    <th align="center">
                                                        Bank Name
                                                    </th>
                                                    <th align="center">
                                                        Amount
                                                    </th>
                                                    <th align="center">
                                                        Response Code
                                                    </th>
                                                    <th align="center">
                                                        Response Msg
                                                    </th>
                                                    <th align="center">
                                                        TxnId
                                                    </th>
                                                    <th align="center">
                                                        Cheque/DD No
                                                    </th>
                                                    <th align="center">
                                                        Transaction Status
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
                        <td class="w-5p">
                        </td>
                    </tr>
                </table>
                <div id="divMessage" runat="server" class="hide">
                    <div class="ui-state-highlight ui-corner-all">
                        <p>
                            <span class="ui-icon ui-icon-info pull-left v-top"></span>
                            <asp:Label ID="lblErrMsg" class="red bold" runat="server"></asp:Label>
                            <a href="#" class="message-dismiss pull-right ui-icon ui-icon-circle-close">Dismiss</a>
                        </p>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnorgid" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    // GetData();


    //$(document).ready(
    function GetData() {
        debugger;
        try {
            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date');
                return false;
            }
            if (document.getElementById('txtTo').value == '') {
                alert('select To Date');
                return false;
            }
            var ddlFilter = document.getElementById('ddlFilterby').value;
            if (document.getElementById('ddlFilterby').value == 'all') {
                ddlFilter = '';
            }

            var FilterType = ddlFilter;
            var Clientcode = document.getElementById('hdnClientID').value; //= 'GENERAL';
            var orgid = document.getElementById('hdnorgid').value;
            var fromdate = document.getElementById('txtFrom').value;
            var todate = document.getElementById('txtTo').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetReceiptStatus",
                contentType: "application/json;charset=utf-8",
                data: "{'orgid':'" + orgid + "','Clientcode':'" + Clientcode + "','FilterType':'" + FilterType + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#tblReceiptStatus').hide();
                    return false;
                }
            });
            $('#tblReceiptStatus').show();
        }
        catch (e) {
        }
        return false

    };
    //);


    function AjaxGetFieldDataSucceeded(result) {
        debugger;
        try {

            var oTable;
            if (result != "[]") {
                oTable = $('#tblReceiptStatus').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    //"fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
            { "mDataProp": "Address2", sClass: "w-8p a-left" }, //date
            {"mDataProp": "ClientName", sClass: "w-10p a-left" },
            { "mDataProp": "PaymentReceiptNo", sClass: "w-5p a-left" },
             { "mDataProp": "Mode", sClass: "w-5p a-left" },
                { "mDataProp": "SubSourceCode", sClass: "w-5p a-left" }, //PaymentType
                { "mDataProp": "BankName", sClass: "w-5p a-left" },
            { "mDataProp": "Amount", sClass: "w-5p a-right" },
             { "mData": "ResponseCode", sClass: "w-4p a-center", "mRender": function(data, type, full) { //Response Code
                 debugger;
                 if (data == 0) {
                     return '<label style="color:green; font-weight: bold;" >' + data + '</label>';
                 }
                 return '<label style="color: red ; font-weight: bold;" >' + data + '</label>';

             }
             },
           { "mData": "Remarks", sClass: "w-15p a-left", "mRender": function(data, type, full) { //Response Message
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
              { "mDataProp": "ChequeNo", sClass: "w-5p a-right" },
         { "mData": "Status", sClass: "w-5p a-center", "mRender": function(data, type, full) { //Status
             //var ResponseArr = data.split(',');
             // var ResultValue = ResponseArr[0].split(':');
             // var ResultRespondeMsg = ResponseArr[1].split(':');

             if (data == 'Pending') {

                 return '<label style="color:#800000 ; font-weight: bold;" >' + data + '</label>';
             }
             else if (data == 'Recommended') {
                 return '<label style="color: #000080 ; font-weight: bold;" >' + data + '</label>';
             }
             else if (data == 'Approved') {
                 return '<label style="color: green ; font-weight: bold;" >' + data + '</label>';
             }
             else if (data == 'Rejected') {
                 return '<label style="color:red; font-weight: bold;" >' + data + '</label>';
             }

         }
         }
                    //{"mDataProp": "Status", sClass: "w-7p a-left" }

],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [],
                    "order": [],
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
                $('#tblReceiptStatus').show();
            }
        }
        catch (e) {
            debugger;
            alert('Exception while binding Data');
        }

        return false;
    }

	
</script>

<script language="javascript" type="text/javascript">

    function pageLoad() {
        $("#txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback
        $("#txtTo").datepicker({
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
    $("#txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });

        $("#txtTo").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });
       
        
       
    }); 
                      
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

