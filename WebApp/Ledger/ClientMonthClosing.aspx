<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientMonthClosing.aspx.cs"
    Inherits="Ledger_ClientMonthClosing" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
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
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="uplmonthcls" runat="server">
        <ContentTemplate>
            <div class="contentdata" style="text-align: center">
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor w-100p">
                                <table class="w-100p searchPanel">
                                    <tr class="panelHeader">
                                        <td class="colorforcontent w-100p" height="23" align="center">
                                            <asp:Label ID="Rs_FilterResult2" runat="server" Text=" Client Month Closing Ledger"
                                                meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="w-100p">
                                                <table class="w-100p m-auto">
                                                    <tr class="a-center">
                                                        <td class="w-10p">
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:Label ID="Rs_From" Text="From Date" Font-Bold="true" runat="server"></asp:Label>
                                                            <asp:TextBox runat="server" ID="txtFrom" onchange="FromDateCheck();" CssClass="datePicker"
                                                                MaxLength="25" size="20" Width="10%"></asp:TextBox>
                                                            <asp:Label ID="Rs_To" Text="To Date" Font-Bold="true" runat="server"></asp:Label>
                                                            <asp:TextBox runat="server" onchange="DateCheck();" ID="txtTo" MaxLength="25" CssClass="datePicker"
                                                                size="20" Width="10%"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnClientID" runat="server" />
                                                            <asp:Label ID="lblClientName" Font-Bold="true" Text="Client Name/Code" runat="server"></asp:Label>
                                                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                                                            <img align="middle" alt="" src="../Images/starbutton.png" />
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                                                                OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                OnClientItemOver="SelectedOver" Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                            <asp:Button ID="btnSearch" runat="server" TabIndex="4" Text="Search" CssClass="btn"
                                                                meta:resourcekey="btnChangeResource2" OnClientClick="return TextBoxvalueCheck();" />
                                                            <asp:Button ID="btnReset" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                                                                meta:resourcekey="btnChangeResource2" OnClientClick="return Reset();" />
                                                        </td>
                                                    </tr>
                                                    <table class="w-90p m-auto">
                                                        <tr class="a-center" id="trerror" runat="server" style="display: none; height: 25px">
                                                            <td style="width: 58%">
                                                            </td>
                                                            <td class="a-center" style="width: 30%" align="left">
                                                                <asp:Label ID="lblerror" runat="server" Text="Client Name/Client Code is mandatory!"
                                                                    ForeColor="Red"></asp:Label>
                                                            </td>
                                                            <td style="width: 22%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p">
                                    <tr align="center">
                                        <td class="w-5p">
                                        </td>
                                        <td class="a-center w-90p">
                                            <div id="show" runat="server">
                                                <table id="ClientMonthClosing" style="display: none" class="display">
                                                    <thead>
                                                        <tr>
                                                            <th align="center" height="25px">
                                                                Date
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Client Name
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Opening Balance
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Bills
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Debit
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Credit
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Receipt
                                                            </th>
                                                            <th align="center" height="25px">
                                                                Closing Balance
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
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    </form>
</body>
</html>

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
    function TextBoxvalueCheck() {

        // var txtval = document.getElementById('txtClientName').value;
        if (document.getElementById('txtClientName').value == '') {
            // lbl = document.getElementById('lblerror')
            trerror.style.display = '';
            return false;
        }
        else {
            trerror.style.display = 'none';
            GetData();
            return false;
        }

    }
</script>

<script language="javascript" type="text/javascript">
    // GetData();

    $(document).ready(function() {
        GetData();

    });

    //$(document).ready(
    function GetData() {
        debugger;
        try {
            var ClientCode = document.getElementById('hdnClientID').value; //= 'GENERAL';
            var OrgID = document.getElementById('hdnOrgID').value;
            var from = document.getElementById('txtFrom').value;
            var to = document.getElementById('txtTo').value;
            var currentdate = new Date();
            var datetime = currentdate.getDate() + "/"
                + (currentdate.getMonth()) + "/"
                + currentdate.getFullYear();
            if (from == '' && to == '') {
                from = '01/01/1920';
                to = datetime;
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetClientClosingMonth",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgID + ",'ClientCode':'" + ClientCode + "','from':'" + from + "','to':'" + to + "'}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#ClientMonthClosing').hide();
                    return false;
                }
            });

            $('#ClientMonthClosing').show();

        }
        catch (e) {
        }
        return false

    };
    //);


    function AjaxGetFieldDataSucceeded(result) {
        debugger
        try {

            var oTable;
            if (result != "[]") {
                oTable = $('#ClientMonthClosing').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "sEmptyTable": { "sEmptyTable": "No matching record" },
                    "aoColumns": [
            { "mDataProp": "ClientName", sClass: "w-8p a-left" },
            { "mDataProp": "ClientCode", sClass: "w-20p a-left" },
            { "mDataProp": "OpeningBalance", sClass: "w-5p a-right" },
            { "mDataProp": "Bill", sClass: "w-5p a-right" },
            { "mDataProp": "Debit", sClass: "w-5p a-right" },
            { "mDataProp": "Credit", sClass: "w-5p a-right" },
            { "mDataProp": "Receipt", sClass: "w-5p a-right" },
            { "mDataProp": "OutStanding", sClass: "w-5p a-right" }
           ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [],
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
                $('#ClientMonthClosing').show();
            }
        }
        catch (e) {
            alert('Exception while binding Data');
        }

        return false;
    }

    function Reset() {
        document.getElementById('txtFrom').value = '';
        document.getElementById('txtTo').value = '';
        document.getElementById('txtClientName').value = '';
        trerror.style.display = 'none';
        //document.getElementById('hdnOrgID').value = '';
        document.getElementById('hdnClientID').value='';
        GetData();

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

