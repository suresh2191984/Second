<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockAdjasmentReport.aspx.cs"
    Inherits="InventoryReports_StockAdjasmentReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Product Legend</title>

    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
        var userMsg;
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

    <script language="javascript" type="text/javascript">
        function fun_BindData() {
            var pFromdate = $('#hdnfromdate').val();
            var pTodate = $('#hdnTodate').val();
            var pOrgId = $('#hdnOrgID').val();
            var OrgAddressID = $('#hdnLocationID').val();
            var LocationId = $('#hdnDepartmentID').val();
            var ProductName = $('#hdnProductName').val();

            $.ajax({
                type: "POST",
                url: "../InventoryReports/WebService/InventoryReportsService.asmx/GetStockAdjasment",
                data: '{pFromDate: "' + pFromdate + '",pToDate: "' + pTodate + '",pOrgID: "' + pOrgId + '",OrgAddressID: "' + OrgAddressID + '",LocationID: "' + LocationId + '",pName: "' + ProductName + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var Items = data.d;
                    fun_Adjasment(Items);
                },
                error: function(jqXHR, textStatus, errorThrown) {

                }
            });
        }
        var TRE;
        function fun_Adjasment(JST) {
            TRE = [];
            $.each(JST, function() {
                var ProductName = this.ProductName;
                var LocationName = this.LocationName;
                var RcvdQty = this.RcvdLSUQty;
                var OutFlowQty = this.InvoiceQty;
                var StockReceivedDt = fun_JSON_DM(this.Manufacture);
                var OutFlowDate = fun_JSON_DM(this.ExpiryDate);
                var UserName = this.Name;
                var Remarks = this.Remarks;

                TRE.push([ProductName = ProductName,
                     LocationName = LocationName,
                     RcvdQty = RcvdQty,
                     OutFlowQty = OutFlowQty,
                     StockReceivedDt = StockReceivedDt,
                     OutFlowDate = OutFlowDate,
                     UserName = UserName,
                     Remarks = Remarks
                     ]);
            });


            $("#gvIndents").dataTable().fnDestroy();
            $('#gvIndents').dataTable({

                "bProcessing": true,
                "bPaginate": true,
                "bDeferRender": true,
                "bSortable": false,
                "bJQueryUI": true,
                "aaData": TRE,
                'bSort': true,
                'bFilter': true,

                'sPaginationType': 'full_numbers',
                "sDom": '<"H"Tfr>t<"F"ip>'


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
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
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
                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" 
                                    CssClass="label_title" meta:resourcekey="lblProductResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" runat="server" CssClass="Txtboxsmall" 
                                OnkeyPress="return ValidateMultiLangChar(this) && ValidateMultiLangCharacter(this);"
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
                                    OnClick="btnSearch_Click" 
                                    OnClientClick="javascript:return CheckDates('')" 
                                    meta:resourcekey="btnSearchResource1" />
                                &nbsp;
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="contentArea" runat="server" style="display: block;">
                        <table>
                            <tr>
                                <td align="right">
                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" 
                                        Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" 
                                        meta:resourcekey="lnkExportXLResource1"><u>Export To XL</u></asp:LinkButton>
                                </td>
                                <td align="right">
                                    <asp:Button ID="btnprnt" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnprntResource1" />
                            </tr>
                        </table>
                    </div>
                    <div class="dataheader2" id="divPrintarea">
                        <input type="hidden" id="hdnRowCount" runat="server" />
                        <asp:GridView OnRowCreated="gridView_RowCreated" ID="grdResult" AllowPaging="True"
                            runat="server" AutoGenerateColumns="False" CellPadding="2" CellSpacing="1" OnRowDataBound="grdResult_RowDataBound"
                            PageSize="20" ForeColor="Black" Width="100%" OnPageIndexChanging="grdResult_PageIndexChanging"
                            ShowFooter="True" meta:resourcekey="grdResultResource1">
                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="dataheader1" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" 
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hypProduct" ForeColor="Blue" h Font-Size="12px" Text='<%# Eval("ProductName") %>'
                                            Target="_blank" runat="server" meta:resourcekey="hypProductResource1"></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="LocationName" HeaderText="Location Name" 
                                    ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="RcvdLSUQty" DataFormatString="{0:0.00}" HeaderText="Stock Received Qty"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="InvoiceQty" DataFormatString="{0:0.00}" HeaderText="Stock Issued Qty"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Manufacture" HeaderText="Stock Received Date" 
                                    ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ExpiryDate" HeaderText="Stock OutFlow Date" 
                                    ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource5">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="User Name" 
                                    ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource6">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                </Columns>
                        </asp:GridView>
                        <div>
                            <div id="total" style="text-align: right; padding-right: 8%;" runat="server">
                                <strong>Total Stock Value@SP :</strong> &nbsp; &nbsp; &nbsp;
                                <asp:Label ID="lblTotalStockValue" Text="0" runat="server" 
                                    meta:resourcekey="lblTotalStockValueResource1"></asp:Label>
                                <br />
                                <strong>Total Stock Value@CP :</strong> &nbsp; &nbsp; &nbsp;
                                <asp:Label ID="lblTotalStockValueCP" Text="0" runat="server" 
                                    meta:resourcekey="lblTotalStockValueCPResource1"></asp:Label>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" width="100%">
                    <table id="gvIndents" width="100%" class="dataheaderInvCtrl">
                        <thead>
                            <tr class="dataheader1">
                                <th nowrap="nowrap" width="5%">
                                    <asp:Label ID="lblProductName" runat="server" Text="Product Name" meta:resourcekey="lblDescriptionResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblLocationName" runat="server" Text="Location Name" meta:resourcekey="lblServiceCodeResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblRcvdLSUQty" runat="server" Text="RcvdLSUQty" meta:resourcekey="lblFromDateResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblOutFlowQty" runat="server" Text="OutFlowQty" meta:resourcekey="lblQuantityResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblStockReceivedDt" runat="server" Text="StockReceived Date" meta:resourcekey="lblUnitPriceResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblOutFlowDate" runat="server" Text="OutFlow Date" meta:resourcekey="lblEligibleUnitPriceResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="lblUserName" runat="server" Text="UserName" meta:resourcekey="lblAmountResource1" />
                                </th>
                                <th nowrap="nowrap" width="2%">
                                    <asp:Label ID="Label1" runat="server" Text="Remarks" 
                                        meta:resourcekey="Label1Resource1" />
                                </th>
                            </tr>
                        </thead>
                    </table>
                    <asp:HiddenField ID="hdnIndentsMedicaltotal" runat="server" Value="0" />
                </td>
            </tr>
            <tr align="center">
                <td>
                    <asp:Button ID="btnHome" Text="Home" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" OnClick="btnHome_Click" 
                        meta:resourcekey="btnHomeResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <input type="hidden" runat="server" id="hdnfromdate" />
    <input type="hidden" runat="server" id="hdnTodate" />
    <input type="hidden" runat="server" id="hdnOrgID" />
    <input type="hidden" runat="server" id="hdnLocationID" />
    <input type="hidden" runat="server" id="hdnDepartmentID" />
    <input type="hidden" runat="server" id="hdnProductName" />
    </form>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>
    <script src="../Scripts/Datatable/Jquery.js" type="text/javascript"></script>

</body>
</html>

<script src="../Scripts/Datatable/jquery.dataTables.js" type="text/javascript"></script>

<script src="../Scripts/Datatable/ZeroClipboard.js" type="text/javascript"></script>

<%--  <script src="../Scripts/Datatable/TableTools.js" type="text/javascript"></script>--%>

<script src="../Scripts/Datatable/jquery.dataTables.min.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>


