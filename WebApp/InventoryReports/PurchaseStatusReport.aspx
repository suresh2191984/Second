<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseStatusReport.aspx.cs"
    Inherits="InventoryReports_PurchaseStatusReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Status Report</title>

    <script language="javascript" type="text/javascript">
        var userMsg;
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Alert" : SListForAppMsg.Get("InventoryReports_Error");
        function CheckDates(splitChar) {
            
         
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
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (CheckFromToDate(DateFrom, DateTo)) {
                    GetPurchaseStatusDetails();
                    return false;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                    
            }

        }
    



        function popupprint() {
            var prtContent = document.getElementById('divPrintarea');

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

    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

    <script type="text/javascript">

        $(window).load(function() {
            setTimeout(function() {
                $('#divLoadingGif').hide();
            }, 2000);
        });

        function GetPurchaseStatusDetails() {
            var pFromdate = $('#hdnFromDate').val();
            var pTodate = $('#hdnToDate').val();
            var OrgID = $('#hdnOrgID').val();
            var OrgAddressID = $('#hdnOrgAddressID').val();
            var ddlLocationID = $("#ddlLocation").val();
            var LocationID = ddlLocationID > 0 ? ddlLocationID : $('#hdnLocationID').val();
            var ProductName = $('#txtProduct').val();
            var SearchNo = '';
            var Status = '';

            $.ajax({
                type: "POST",
                url: "../InventoryReports/WebService/InventoryReportsService.asmx/GetPurchaseStatusReport",
                data: '{FromDate: "' + pFromdate + '",ToDate: "' + pTodate + '",OrgID: "' + OrgID + '",OrgAddressID: "' + OrgAddressID + '",LocationID: "' + LocationID + '",ProductName: "' + ProductName + '",Status: "' + Status + '" ,PONo: "' + SearchNo + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var Items = data.d;
                    BindItemList(Items)
                },
                error: function(jqXHR, textStatus, errorThrown) {
var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_09") == null ? "Service Failed' + errorThrown)" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_09");
 ValidationWindow(userMsg, errorMsg);
                }
            });
        }


        var ItemList;
        function BindItemList(Item) {
            ItemList = [];
            $.each(Item, function() {
                //var StockReceivedDt = fun_JSON_DM(this.Manufacture);
                var PurchaseOrderNo = this.ReferenceNo;
                var PurchaseOrderDate = fun_JSON_DM(this.ExpiryDate);
                var SupplierName = this.SupplierName;
                // var Status = this.Status;
                var LaundryStatus = this.LaundryStatus;
                var ProductName = this.ProductName;
                var RaisedQty = this.Quantity;
                var RECQuantity = this.RECQuantity;
                var PendingQty = this.InvoiceQty;
                var LocationName = this.LocationName;

                ItemList.push([
        ReferenceNo = PurchaseOrderNo,
        ExpiryDate = PurchaseOrderDate,
        SupplierName = SupplierName,
        LaundryStatus = LaundryStatus,
        ProductName = ProductName,
        Quantity = RaisedQty,
        RECQuantity = RECQuantity,
        InvoiceQty = PendingQty,
        LocationName = LocationName
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

</head>
<body id="Body1" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/App_Code/InventoryWebService.cs" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divLoadingGif">
            <div id="divProgressBackgroundFilter">
            </div>
            <div align="center" id="divProcessMessage">
                <asp:Label ID="lblPleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                <br />
                <b>
                    <asp:Label ID="LblTotalCount" runat="server" ForeColor="Red" 
                    meta:resourcekey="LblTotalCountResource1" /></b>
                <br />
                <asp:Image ID="imgLoadingGif" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
            </div>
        </div>
        <table border="0" cellpadding="2" cellspacing="1" width="100%">
            <tr>
                <td>
                    <table width="80%" class="dataheader2 defaultfontcolor">
                        <tr>
                            <td>
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                    meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                    CssClass="ddl" meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" 
                                    meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" Width="70px" meta:resourcekey="txtFromResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" 
                                    meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker" Width="70px" 
                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Department" 
                                    CssClass="label_title" meta:resourcekey="lblLocationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" 
                                    meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" 
                                    CssClass="label_title" meta:resourcekey="lblProductResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" runat="server" CssClass="Txtboxsmall" OnkeyPress="return ValidateMultiLangCharacter(this) && ValidateMultiLangChar(this);"
                                    Width="130px" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" 
                                    EnableCaching="False" MinimumPrefixLength="1"
                                    CompletionInterval="10" CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" DelimiterCharacters=";,:" 
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClientClick="javascript:return CheckDates('')" 
                                    meta:resourcekey="btnSearchResource1" />
                            </td>
                            <td>
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                            </td>
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
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnprntResource1" />
                            </tr>
                        </table>
                    </div>
                    <div class="dataheader2" id="divPrintarea">
                        <table id="gvIntendDetails" width="100%" class="dataheaderInvCtrl">
                            <thead>
                                <tr class="dataheader1">
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblPurchaseOrderNo" runat="server" Text="PurchaseOrderNo" 
                                            meta:resourcekey="lblPurchaseOrderNoResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblPurchaseOrderDate" runat="server" Text="Order Date" 
                                            meta:resourcekey="lblPurchaseOrderDateResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblSupplierName" runat="server" Text="SupplierName" 
                                            meta:resourcekey="lblSupplierNameResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" 
                                            meta:resourcekey="lblStatusResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="2%">
                                        <asp:Label ID="lblProductName" runat="server" Text="ProductName" 
                                            meta:resourcekey="lblProductNameResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblQuantity" runat="server" Text="Raised Qty" 
                                            meta:resourcekey="lblQuantityResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblReceivedQty" runat="server" Text="Received Qty" 
                                            meta:resourcekey="lblReceivedQtyResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="1%">
                                        <asp:Label ID="lblRECQuantity" runat="server" Text="Pending Qty" 
                                            meta:resourcekey="lblRECQuantityResource1" />
                                    </th>
                                    <th nowrap="nowrap" width="2%">
                                        <asp:Label ID="lblLocationname" runat="server" Text="Location Name" 
                                            meta:resourcekey="lblLocationnameResource1" />
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </td>
            </tr>
            <tr align="center">
                <td>
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
    </form>
</body>
</html>

<script src="../Scripts/Datatable/Jquery.js" type="text/javascript"></script>

<script src="../Scripts/Datatable/jquery.dataTables.js" type="text/javascript"></script>

<script src="../Scripts/Datatable/ZeroClipboard.js" type="text/javascript"></script>

<script src="../Scripts/Datatable/jquery.dataTables.min.js" type="text/javascript"></script>





