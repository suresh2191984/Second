<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationStockUsage.aspx.cs"
    Inherits="Reports_InvestigationStockUsage" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Issued Report</title>
    <script language="javascript" type="text/javascript">

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
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }


        function CallPrint() {
            var prtContent = document.getElementById('Printdata');

            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }

        function getdeviceid() {
            var deviceid = document.getElementById('drpDevices').value;
            document.getElementById('hdnDeviceID').value = deviceid;
            $find('AutoInvName').set_contextKey(deviceid);
        }

        function fnSelectedInventory(source, eventArgs) {
            var lis = eventArgs.get_value();
            AddInventoryDetails(lis);
        }
        function AddInventoryDetails(obj) {

            var p = obj.split('~');
            if (p.lenght != 0) {
                document.getElementById('txtInvName').value = p[0];
                document.getElementById('hdnInvID').value = p[1];
            }
            else {
                document.getElementById('hdnInvID').value = '0';
            }

        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="dataheader2 defaultfontcolor" border="0" width="100%" cellpadding="2"
            cellspacing="1">
            <tr>
                <td>
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="font-weight: bold">
                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker" Width="120px"
                                    TabIndex="1" MaxLength="1" Style="text-align: justify" ValidationGroup="MKE"
                                    meta:resourcekey="txtFromResource1" />
                                <%-- <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                    ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                    PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />--%>
                            </td>
                            <td style="font-weight: bold">
                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker" Width="120px"
                                    TabIndex="2" MaxLength="1" Style="text-align: justify" ValidationGroup="MKE"
                                    meta:resourcekey="txtToResource1" />
                                <%-- <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />--%>
                                <%--  <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                    ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />--%>
                            </td>
                            <td width="28%">
                                Product Name
                                <asp:TextBox ID="txtProduct" runat="server" Style="margin-left: 0px" CssClass="Txtboxmedium">
                                </asp:TextBox><ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                    TargetControlID="txtProduct" ServiceMethod="GetSearchProductList" ServicePath="~/InventoryWebService.asmx"
                                    EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                    DelimiterCharacters=";,:" FirstRowSelected="false">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td width="28%">
                                Department &nbsp;&nbsp;
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlmedium" TabIndex="4"
                                    Style="margin-left: 0px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold">
                                <asp:Label ID="lableDeviceName" runat="server" Text="DeviceName"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDevices" runat="server" Width="150px" CssClass="bilinvddltb"
                                    onchange="getdeviceid();">
                                </asp:DropDownList>
                                <input id="hdnDeviceID" runat="server" type="hidden" value="0" />
                            </td>
                            <td style="font-weight: bold">
                                <asp:Label ID="LabelInvestigationName" runat="server" Text="Investigation Name"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvName" runat="server" TabIndex="2" />
                                <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtInvName"
                                    ServiceMethod="GetInventoryList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                    MinimumPrefixLength="2" OnClientItemSelected="fnSelectedInventory" CompletionInterval="10"
                                    DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                </ajc:AutoCompleteExtender>
                                <input id="hdnInvID" runat="server" type="hidden" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClientClick="javascript:return CheckDates()" TabIndex="5" OnClick="btnSearch_Click"
                                    meta:resourcekey="btnSearchResource1" />
                            </td>
                            <td id="tdExcel" runat="server" style="display: none">
                                <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                    ToolTip="Save As Excel" />
                                <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="true"
                                    Visible="true" Font-Size="12px" ForeColor="#000000" ToolTip="Save As Excel"><u>Export To XL</u></asp:LinkButton>
                                &nbsp;&nbsp;
                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../Images/printer.GIF"
                                    ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();" />
                                <asp:LinkButton ID="lnkPrint" runat="server" Font-Bold="true" OnClientClick="return CallPrint();"
                                    Visible="true" Font-Size="12px" ForeColor="#000000" ToolTip="Click Here To Print Stock Details"><u>Print</u></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <div id="divPrint" style="display: none;" runat="server">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="left" style="padding-right: 10px; color: #000000;">
                                    <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                        runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                    <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                        meta:resourcekey="btnConverttoXLResource1" />
                                </td>
                                <td align="right" style="padding-right: 10px; color: #000000;">
                                    <b id="printText" runat="server">
                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return CallPrint();"
                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lblNoResult" Text="No Results." Font-Bold="True" ForeColor="#000333"
                        Style="display: none;" runat="server" meta:resourcekey="lblNoResultResource1"></asp:Label>
            </tr>
            <tr>
                <td class="dataheader2">
                    <div id="Printdata">
                        <asp:GridView ID="grdResult" EmptyDataText="No Results Found." runat="server" CssClass="mytable1"
                            AutoGenerateColumns="False" ShowFooter="false" Width="100%" meta:resourcekey="grdResultResource1">
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle HorizontalAlign="Right" Font-Size="10px" />
                            <Columns>
                                <asp:BoundField HeaderText="Investigation Name" DataField="InvestigationName" meta:resourcekey="BoundFieldResource1" />
                                <asp:BoundField HeaderText="TestCount" DataField="InvestigationQty" />
                                <asp:BoundField HeaderText="ProductName" DataField="ProductName" meta:resourcekey="BoundFieldResource3" />
                                <asp:BoundField HeaderText="Estimated Quantity" DataField="EstimateQty" />
                                <asp:BoundField HeaderText="Buffer Quantity" DataField="BufferQty" />
                                <asp:BoundField HeaderText="Actual Quantity" DataField="ActualQty" />
                                <asp:BoundField HeaderText="Usage Quantity" DataField="UsedQty" />
                                <asp:BoundField HeaderText="Unit" DataField="eunits" />
                            </Columns>
                        </asp:GridView>
                        <%-- <asp:GridView ID="GridView1" runat="server"
                                        AutoGenerateColumns="False"  
                                        BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                                        GridLines="Horizontal" ForeColor="Black" 
                                        Height="119px"
                                        OnDataBound="GridView1_DataBound1"> 
                                        <RowStyle HorizontalAlign="Right" Font-Size="10px" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Investigation Name" DataField="InvestigationName" />
                                            <asp:BoundField HeaderText="Investigation Qty" DataField="InvestigationQty" />
                                            <asp:BoundField HeaderText="ProductName" DataField="ProductName" />
                                            <asp:BoundField HeaderText="Estimated Qty" DataField="EstimateQty" />
                                            <asp:BoundField HeaderText="Buffer Qty" DataField="BufferQty" />
                                            <asp:BoundField HeaderText="Actual Qty" DataField="ActualQty" />
                                            <asp:BoundField HeaderText="Used Qty" DataField="UsedQty" />
                                        </Columns>
                                        </asp:GridView>--%>
                    </div>
                </td>
            </tr>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>