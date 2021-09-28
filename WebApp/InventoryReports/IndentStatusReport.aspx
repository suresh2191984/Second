<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndentStatusReport.aspx.cs"
    Inherits="InventoryReports_IndentStatusReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>Indent Status Report</title>
    <style type="text/css">
        .listtwo > li
        {
            z-index: 2;
        }
    </style>

    <script language="javascript" type="text/javascript">
       
        var userMsg;
        function CheckDates() {
            var splitChar = '/';
            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                if (CheckFromToDate(DateFrom, DateTo)) {
                    GetIndentStatusDetails();
                    return false;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }



        function popupprint() {
            var prtContent = document.getElementById('divPrintarear');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function clearContextText() {
            $('#contentArea').hide();
        }

    </script>

</head>
<body id="Body1" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryReports/WebService/InventoryReportsService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
      <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error")
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information")
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel")
    </script>
    <div class="contentdata">
        <table border="0" cellpadding="2" cellspacing="1" width="100%">
            <tr>
                <td>
                    <table width="80%" class="dataheader2 defaultfontcolor">
                        <tr>
                            <td>
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrustedOrg" OnSelectedIndexChanged="LoadsharedorgLocation" AutoPostBack="true" runat="server"
                                    CssClass="ddl" meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="small datePicker" Width="70px"
                                    meta:resourcekey="txtFromResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="small datePicker" Width="70px" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Department" CssClass="label_title"
                                    meta:resourcekey="lblLocationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" CssClass="label_title"
                                    meta:resourcekey="lblProductResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="Txtboxsmall" Width="130px"
                                    meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False" MinimumPrefixLength="1"
                                    CompletionInterval="10" CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" DelimiterCharacters=";,:" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClientClick="javascript:return CheckDates()" meta:resourcekey="btnSearchResource1" />
                            </td>
                          <%--  <td>
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                    meta:resourcekey="lnkBackResource1"><%=Resources.InventoryReports_ClientDisplay.InventoryReports_IndentStatusReport_aspx_01%>&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                            </td>--%>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="contentArea" runat="server" style="display: none;">
                        <table>
                            <tr>
                                <td align="right">
                                </td>
                                <td align="right">
                                    <asp:Button ID="btnprnt" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" meta:resourcekey="btnprntResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="dataheader2" id="divPrintarear">
                        <table id="gvIntendDetails" width="100%" class="dataheaderInvCtrl">
                            <thead>
                                <tr class="dataheader1">
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblIntendNo" runat="server" Text="IndentNo" meta:resourcekey="lblIntendNoResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblIndentDate" runat="server" Text="Indent Date" meta:resourcekey="lblIndentDateResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatusResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="2%">
                                        <asp:Label ID="lblRaisedLocation" runat="server" Text="Raised Location" meta:resourcekey="lblRaisedLocationResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="2%">
                                        <asp:Label ID="lblIssuedLocation" runat="server" Text="Issued Location" meta:resourcekey="lblIssuedLocationResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="2%">
                                        <asp:Label ID="lblProductName" runat="server" Text="ProductName" meta:resourcekey="lblProductNameResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblQuantity" runat="server" Text="Raised Qty" meta:resourcekey="lblQuantityResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblIssuedQty" runat="server" Text="Issued Qty" meta:resourcekey="lblIssuedQtyResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblRECQuantity" runat="server" Text="Received Qty" meta:resourcekey="lblRECQuantityResource1" />
                                    </th>
                                     <th nowrap="nowrap" width="1%" id="stockmissing" style="display:none;">
                                        <asp:Label ID="lblstockmissing" runat="server" Text="Missing Stock" meta:resourcekey="lblstockmissingResource1" />
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnFromDate" runat="server" />
    <asp:HiddenField ID="hdnToDate" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnOrgAddressID" runat="server" />
    <asp:HiddenField ID="hdnLocationID" runat="server" />
    <asp:HiddenField ID="hdnProductName" runat="server" />
    <asp:HiddenField ID="hdnSearchNo" runat="server" />
    <asp:HiddenField ID="hdnconfigvalue" runat="server" />
    </form>
</body>
</html>

<script src="../PlatForm/Scripts/DataTable/jquery.dataTables.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/DataTable/ZeroClipboard.js" type="text/javascript"></script>

<%--<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

<script type="text/javascript">

    function GetIndentStatusDetails() {
        var pFromdate = $('#txtFrom').val();
        var pTodate = $('#txtTo').val();
        var OrgID = $('#ddlTrustedOrg').val();
        var OrgAddressID = 0;
        var ddlLocationID = $("#ddlLocation").val();
        var LocationID = ddlLocationID > 0 ? ddlLocationID : $('#hdnLocationID').val();
        var ProductName = $('#txtProduct').val();
        var SearchNo = '';
        var Status = '';

        $.ajax({
            type: "POST",
            url: "../InventoryReports/WebService/InventoryReportsService.asmx/GetIndentStatusReport",
            data: '{FromDate: "' + pFromdate + '",ToDate: "' + pTodate + '",OrgID: "' + OrgID + '",OrgAddressID: "' + OrgAddressID + '",LocationID: "' + LocationID + '",ProductName: "' + ProductName + '",Status: "' + Status + '" ,SearchNo: "' + SearchNo + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {
                var Items = data.d;
                BindItemList(Items)
            },
            error: function(jqXHR, textStatus, errorThrown) {
                var userMsg = SListForAppMsg.Get("InventoryReports_IndentStatusReport_aspx_09") == null ? "Failed " + errorThrown : SListForAppMsg.Get("InventoryReports_IndentStatusReport_aspx_09");
                ValidationWindow(userMsg, errorMsg);
            }
        });
    }

    //ExpiryDate -- IndentDate
    //LaundryStatus --Status
    //ReferenceNo -- IndentNo
    //RECQuantity -- indent issue qty
    //InvoiceQty --Received indent qty
    //LocationName--RaisedLocation
    //Description --Issued Location
    var ItemList;
    function BindItemList(Item) {
        if (document.getElementById('hdnconfigvalue').value == 'Y') 
        {
            $("#stockmissing").show();
        }
        ItemList = [];
        if (document.getElementById('hdnconfigvalue').value == 'Y') {
        $.each(Item, function() {
            //var StockReceivedDt = fun_JSON_DM(this.Manufacture);
            var ReferenceNo = this.ReferenceNo;
            var ExpiryDate = fun_JSON_DM(this.ExpiryDate);
            var LaundryStatus = this.LaundryStatus;
            var LocationName = this.LocationName;
            var Description = this.Description;
            var ProductName = this.ProductName;
            var Quantity = this.Quantity;
            var RECQuantity = this.RECQuantity;
            var InvoiceQty = this.InvoiceQty;
                var StockMissing = this.StockDamage;

            ItemList.push([
                                    ReferenceNo = ReferenceNo,
                                    ExpiryDate = ExpiryDate,
                                    LaundryStatus = LaundryStatus,
                                    LocationName = LocationName,
                                    Description = Description,
                                    ProductName = ProductName,
                                    Quantity = Quantity,
                                    RECQuantity = RECQuantity,
                                    InvoiceQty = InvoiceQty,
                                    StockMissing = StockMissing
                                                 ]);
        });
        }
        else

            $.each(Item, function() {
                //var StockReceivedDt = fun_JSON_DM(this.Manufacture);
                var ReferenceNo = this.ReferenceNo;
                var ExpiryDate = fun_JSON_DM(this.ExpiryDate);
                var LaundryStatus = this.LaundryStatus;
                var LocationName = this.LocationName;
                var Description = this.Description;
                var ProductName = this.ProductName;
                var Quantity = this.Quantity;
                var RECQuantity = this.RECQuantity;
                var InvoiceQty = this.InvoiceQty;
                var StockMissing = "";

                ItemList.push([
                                    ReferenceNo = ReferenceNo,
                                    ExpiryDate = ExpiryDate,
                                    LaundryStatus = LaundryStatus,
                                    LocationName = LocationName,
                                    Description = Description,
                                    ProductName = ProductName,
                                    Quantity = Quantity,
                                    RECQuantity = RECQuantity,
                                    InvoiceQty = InvoiceQty,
                                    StockMissing=StockMissing
                                    

                                                 ]);
            });
        




        $("#gvIntendDetails").dataTable().fnDestroy();

        $("#gvIntendDetails").dataTable({

            "bProcessing": true,
            "bPaginate": true,
            "bDeferRender": true,
            "bSortable": false,
            "bJQueryUI": true,
            "aaData": ItemList,
            'bSort': true,
            'bFilter': true,
            'bSortClasses': false,
            'iDisplayLength': 25,
            'sPaginationType': 'full_numbers'

        });

    }

    function fun_JSON_DT(DST) {
        var m, day;
        JDT = DST;
        var d = new Date(parseInt(JDT.substr(6)));
        m = d.getMonth() + 1;
        if (m < 10)
            m = '0' + m
        if (d.getDate() < 10)
            day = '0' + d.getDate()
        else
            day = d.getDate();

        return (day + '/' + m + '/' + d.getFullYear())
    }


    function fun_JSON_DM(DST) {
        var m, day, MIT;
        JDT = DST;
        var d = new Date(parseInt(JDT.substr(6)));
        m = d.getMonth() + 1;
        if (m < 10)
            m = '0' + m
        if (d.getDate() < 10)
            day = '0' + d.getDate()
        else
            day = d.getDate();

        var HOU = d.getHours();
        var MIN = d.getMinutes();

        if (Number(HOU) > 12) {
            HOU = Number(HOU) - 12;
            if (HOU < 10) { HOU = '0' + HOU }
            MIT = HOU + ':' + MIN + 'PM';
        }
        else {
            if (HOU < 10) { HOU = '0' + HOU }
            MIT = HOU + ':' + MIN + 'AM';
        }
        return (day + '-' + m + '-' + d.getFullYear() + ' ' + MIT)
    }


</script>

