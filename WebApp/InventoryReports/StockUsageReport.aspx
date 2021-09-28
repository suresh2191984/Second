<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockUsageReport.aspx.cs" Inherits="InventoryReports_StockUsageReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Issued Report</title>
    <script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //petchi
        function ProductItemsSelected(source, eventArgs) {
            //debugger;
            var Product = eventArgs.get_text().split('^^');
            document.getElementById('txtProduct').value = Product[0];

        }
         var  userMsg;
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
                     return true;
                 } else {
                     var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                     ValidationWindow(userMsg, errorMsg);
                     return false;
                 }

             }

         }
        function onSearch() {
            var txt = document.getElementById('txtProduct').value;
            if (txt.trim() != "") {
                document.getElementById('btnSearch').click();
                document.getElementById('btnSearch').disabled = true;
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('divPrintarea');

            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        function clearContextText() {
            $('#contentArea').hide();
            $('#divPrint').hide();
            $('#lblNoResult').hide(); 
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
                                    <table class="w-100p">
                                        <tr>
                                            <td id="tdlblOrgs" style="display:none;">
                                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                                    meta:resourcekey="lblOrgsResource1"></asp:Label>
                                            </td>
                                            <td id="tdddlTrustedOrg" style="display:none;">
                                                <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" onchange="javascript:clearContextText();"
                                                    runat="server" CssClass="ddl" 
                                                    OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged" 
                                                    meta:resourcekey="ddlTrustedOrgResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="font-weight: bold;display:none;">
                                                <asp:Label runat="server" ID="lblDepartment" Text="Issued To Location" CssClass="label_title"
                                                    meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                            </td>
                                            <td id="tdddlLocation" style="display:none;" >
                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" Width="130px" 
                                                            meta:resourcekey="ddlLocationResource1">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td class="bold w-5p">
                                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                            </td>
                                            <td class="w-20p">
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFromResource1" />
                                            </td>
                                            <td class="bold w-3p">
                                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                            </td>
                            <td class="w-25p">
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1" />
                                            </td>
                                            <td style="font-weight: bold;display:none;">
                                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" meta:resourcekey="lblProductResource1"></asp:Label>
                                            </td>
                                            <td style="font-weight: bold;display:none;">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                        <asp:TextBox ID="txtProduct" CssClass="Txtboxsmall" runat="server" Width="130px"
                                            OnkeyPress="return ValidateMultiLangCharacter(this) && ValidateMultiLangChar(this);"
                                            meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct" OnClientItemSelected="ProductItemSelected"
                                                            ServiceMethod="GetSearchProductList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                                            DelimiterCharacters=";,:" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td class="a-left">
                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                    OnClick="btnSearch_Click" OnClientClick="javascript:return CheckDates('')" TabIndex="5"
                                                    meta:resourcekey="btnSearchResource1" />
                                                <asp:Button ID="lnkBack" Text="Back" Font-Underline="False" runat="server" CssClass="cancel-btn"
                                                    Width="40px" OnClick="lnkBack_Click" TabIndex="6" meta:resourcekey="lnkBackResource1"></asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                        runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                                    <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                                        OnClick="btnConverttoXL_Click" meta:resourcekey="btnConverttoXLResource1" />
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"
                                                            OnClientClick="return CallPrint();"></asp:Label></b>&nbsp;&nbsp;
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../PlatForm/Images/printer.gif" OnClientClick="return CallPrint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Label ID="lblNoResult" Text="No Results." Font-Bold="True" ForeColor="#000333"
                                        Style="display: none;" runat="server" meta:resourcekey="lblNoResultResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="contentArea">
                                        <input type="hidden" id="hdnRowCount" runat="server" />
                                        <asp:HiddenField ID="hdnLocation" runat="server" Value="1" />
                                        <div id="divPrintarea" runat="server" style="overflow: auto; height: 350px;width:1348px;">
                                            <asp:GridView OnRowCreated="gridView_RowCreated" ID="grdResult" EmptyDataText="No Results Found."
                                                OnRowDataBound="grdResult_RowDataBound" CssClass="w-100p gridView" AutoGenerateColumns="False"
                                                Width="100%" meta:resourcekey="grdResultResource1" runat="server">
                                                <HeaderStyle CssClass="gridHeader" />
                                                <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                 
                                                    <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource2" />
                                                 
                                                    <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" meta:resourcekey="BoundFieldResource4" />
                                                    <%-- <asp:BoundField DataField ="UnitPrice" HeaderText="UnitPrice" />--%>
                                                   
                                                    
                                                    <%-- <asp:BoundField DataField="TUnitPrice" HeaderText ="TotalUP" />--%>
                                                  <asp:BoundField DataField="InvoiceDate" HeaderText="Usage Date" meta:resourcekey="BoundFieldResource1" 
                                                         />
                                                    <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" meta:resourcekey="BoundFieldResource3" 
                                                         />
												    
                                                    <asp:BoundField DataField="LocationName" HeaderText="Issued To" meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField DataField="Quantity" HeaderText="Qty" meta:resourcekey="BoundFieldResource14" />
                                                        <asp:BoundField DataField="Comments" HeaderText="Comments" 
                                                        meta:resourcekey="BoundFieldResource5" />
                                                </Columns>
                                            </asp:GridView>
                                            <hr />
                                            <table id="tbtotal" runat="server" visible="false" class="w-100p">
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblTotalCPtxt" Font-Bold="True" ForeColor="#000333" Text="Total CP"
                                                            runat="server" meta:resourcekey="lblTotalCPtxtResource1"></asp:Label>=
                                                        <asp:Label ID="lblTotalCP" Font-Bold="True" ForeColor="#000333" Text="0.00" runat="server"
                                                            meta:resourcekey="lblTotalCPResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblTotalSPtxt" Font-Bold="True" ForeColor="#000333" Text="Total SP"
                                                            runat="server" meta:resourcekey="lblTotalSPtxtResource1"></asp:Label>=
                                                        <asp:Label ID="lblTotalSP" Font-Bold="True" ForeColor="#000333" Text="0.00" runat="server"
                                                            meta:resourcekey="lblTotalSPResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
		<Attune:Attunefooter ID="Attunefooter" runat="server" />
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>