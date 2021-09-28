<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Expirydatedetails.aspx.cs"
    Inherits="InventoryReports_Expirydatedetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>ExpireDateDetails</title>

    <script language="javascript" type="text/javascript">
        
        function ValidateDate() {
            var userMsg = SListForAppMsg.Get("InventoryReports_Expirydatedetails_aspx_01") != null ? SListForAppMsg.Get("InventoryReports_Expirydatedetails_aspx_01") : "Select from date and to date";
            var errorMsg = SListForAppMsg.Get("InventoryReports_Error") != null ? SListForAppMsg.Get("InventoryReports_Error") : "Alert";
            if (document.getElementById('txtFrom').value == '') {
                var expdate = GetServerDate();
                ValidationWindow(userMsg, errorMsg);
            }
            else if (document.getElementById('txtTo').value == '') {

                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                return checkFromDateToDate('txtFrom', 'txtTo');
            }
        }
        function doPrint() {
            $('#tblHostional').removeClass().addClass('show w-100p a-center');           
            var PrtLog = document.getElementById('tblHostional');     
            
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //document.getElementById('tdBtns').style.display = "none";
            WinPrint.document.write($('head').html() +PrtLog.innerHTML);
            WinPrint.document.write($('head').html() +document.getElementById('divPrint').innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            $('#tblHostional').removeClass().addClass('hide');
            return false;
            //  document.getElementById('tdBtns').style.display = "Block";

        }

        function onCalendarShown2() {

            var cal = $find("calendar2");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }
        }

        function onCalendarHidden2() {
            var cal = $find("calendar2");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }

        }

        function call2(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar2");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
 
           function CheckDates() {

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
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater than To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
        function onCalendarShown() {

            var cal = $find("calendar1");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }
        }

        function onCalendarHidden() {
            var cal = $find("calendar1");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }

        }

        function call(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar1");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('divPrint');
            $('#tblHostional').removeClass().addClass('show w-100p a-center');           
            var PrtLog = document.getElementById('tblHostional');     
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write($('head').html() +PrtLog.innerHTML);
            WinPrint.document.write($('head').html() +prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            $('#tblHostional').removeClass().addClass('hide');
            return false;
        }

        function clearContextText() {
            $('#contentArea').hide();
        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <table class="searchPanel padding10">
                        <tr class="panelContent">
                            <td>
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgs"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                    CssClass="small" meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="fromDate" Text="From Date" meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="xsmaller datePickerfunture" meta:resourcekey="txtFromResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="toDate" Text="To Date" meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" CssClass="xsmaller datePickerfunture" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" CssClass="label_title"
                                    meta:resourcekey="lblProductResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" CssClass="small" runat="server" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList" FirstRowSelected="true"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False" MinimumPrefixLength="1"
                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="listitemtwo" DelimiterCharacters=";,:" 
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            
                        </tr>
                        <tr >
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td >
                                <asp:DropDownList ID="ddlLocation" onchange="javascript:clearContextText();" runat="server"
                                    CssClass="small" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClick="btnSearch_Click" OnClientClick="javascript:return CheckDates();"  meta:resourcekey="btnSearchResource1" />
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
                                    meta:resourcekey="lnkBackResource1" Text="Cancel"></asp:LinkButton>
                            </td>
                            <td>
                                <div id="divTool" runat="server" class="a-left">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:ImageButton ID="imgBtnPrint" runat="server" CssClass="marginL10" ImageUrl="../PlatForm/Images/printer.GIF"
                                                ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"
                                                meta:resourcekey="imgBtnPrintResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="hide" id="contentArea" runat="server">
                        <div id="divExp" runat="server">
                            <div class="hide" id="divLegend">
                                <table id="tblLegend">
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtExpiredColor" ReadOnly="True" runat="server" CssClass="tiny"
                                                meta:resourcekey="txtExpiredColorResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblExpired" Text="Already Expired Products" runat="server" meta:resourcekey="lblExpiredResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtExpLevelColor" ReadOnly="True" runat="server" CssClass="tiny"
                                                meta:resourcekey="txtExpLevelColorResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblExpLevel" Text="Products Expires Within " runat="server" meta:resourcekey="lblExpLevelResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                        </div>
                        <div id="divPrint" class="w-100p" runat="server" visible="false">
                            <table>
                                <tr id="trtotal" runat="server">
                                    <td class="a-right" id="tdTotalclosingStockValueCP">
                                        <strong><asp:Label ID="lbltotalcp" runat="server" Text="Total closing Stock Value in CP:"
                                        meta:resourcekey="lbltotalcpResources"></asp:Label>
                                            <asp:Label ID="lblTotalStockValueCP" Text="0" runat="server" 
                                            meta:resourcekey="lblTotalStockValueCPResource1"></asp:Label></strong>
                                    </td>
                                    <td>
                                    </td>
                                    <td id="tdTotalclosingStockValueSP">
                                        <strong><asp:Label ID="lbltotalsp" runat="server" Text="Total closing Stock Value in SP:"
                                        meta:resourcekey="lbltotalspResources"></asp:Label>
                                            <asp:Label ID="lblTotalStockValueSP" Text="0" runat="server" 
                                            meta:resourcekey="lblTotalStockValueSPResource1"></asp:Label></strong>
                                    </td>
                                </tr>
                            </table>
                            <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                                AutoGenerateColumns="False" CssClass="gridView w-100p" OnPageIndexChanging="grdResult_PageIndexChanging"
                                PageSize="20" OnSelectedIndexChanged="grdResult_SelectedIndexChanged" OnRowDataBound="grdResult_RowDataBound"
                                meta:resourcekey="grdResultResource1">
                                <Columns>
                                    <asp:BoundField HeaderText="ProductID" DataField="ProductID" Visible="false" meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField HeaderText="Supplier Name" DataField="SupplierName" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField HeaderText="Invoice No" DataField="RakNo" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" meta:resourcekey="BoundFieldResource5" />
                                    <asp:BoundField HeaderText="Units" DataField="Unit" meta:resourcekey="BoundFieldResource6" />
                                    <asp:TemplateField HeaderStyle-CssClass="a-center" ItemStyle-CssClass="a-left" HeaderText="Expiry Date"
                                        meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExpDate" Text='<%# Eval("ExpiryDate","{0:MMM/yyyy}") %>' runat="server"
                                                meta:resourcekey="lblExpDateResource1"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="a-center"></HeaderStyle>
                                        <ItemStyle CssClass="a-left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-CssClass="a-center" HeaderText="InHand Qty" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInHandQty" Text='<%# Eval("InHandQuantity","{0:N}") %>' runat="server"
                                                meta:resourcekey="lblInHandQtyResource1"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="a-center"></HeaderStyle>
                                        <ItemStyle CssClass="a-right"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Closing Stock Value @SP" DataField="TSellingPrice" DataFormatString="{0:N}"  meta:resourcekey="BoundFieldResource7">
                                        <ItemStyle CssClass="a-right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Closing Stock Value @CP" DataField="UnitPrice" DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource8">
                                        <ItemStyle CssClass="a-right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Location" DataField="LocationName" meta:resourcekey="BoundFieldResource9">
                                        <ItemStyle CssClass="a-right"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                                <PagerStyle CssClass="gridPager a-center" />
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <div id="tblHostional" class="hide">
            <table class="searchPanel w-100p">
                <tr>
                    <td class="a-left w-5p v-bottom">
                        <img id="imgPath" runat="server" />
                    </td>
                    <td class="a-left">
                        <asp:Label ID="lblHospital" runat="server" 
                            meta:resourcekey="lblHospitalResource1" />
                    </td>
                </tr>
                <tr class="panelHeader">
                    <td class="a-center" colspan="2">
                        <asp:Label ID="lblReportName" runat="server" 
                            meta:resourcekey="lblReportNameResource1" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnIsSellingPriceTypeRuleApply" runat="server" Value ="N" />
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        if ($('#hdnIsSellingPriceTypeRuleApply').val() == 'Y') {
            $("#tdTotalclosingStockValueSP").css('visibility', 'hidden');
        }
        else {
            //$("#dvBillLevdiscount").hide();
        }
    });
	$(window).on('beforeunload', function () {
		$('#preloader').hide();
	});
 </script>