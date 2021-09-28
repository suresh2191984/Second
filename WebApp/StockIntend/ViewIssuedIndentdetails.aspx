<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewIssuedIndentdetails.aspx.cs"
    Inherits="Inventory_ViewIssuedIndentdetails" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Indent Detail View</title>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />-

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divXsltPrint" class="h-100p" runat="server">
            <asp:Xml ID="xmlIndentView" runat="server"></asp:Xml>
        </div>
        <div id="divProjection" runat="server">
            <table class="w-100p searchPanel">
                <tr>
                    <td class="a-center">
                        <%-- CssClass="hide"--%>
                        <asp:Image ID="imgBillLogo" runat="server" meta:resourcekey="imgBillLogoResource1" />
                        <br />
                        <asp:Label CssClass="bold" ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" meta:resourcekey="lblstreetResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p searchPanel" runat="server" id="tblIndentInfo">
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="LabelIndentNo" Text="Indent No :" class="bold" runat="server" meta:resourcekey="LabelIndentNoResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left w-50p">
                                    <asp:Label ID="lblIntendNo" runat="server" meta:resourcekey="lblIntendNoResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="LabelDate" Text="Raised Date :" class="bold" runat="server" meta:resourcekey="LabelDateResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="trTransferorNo" class="hide">
                                <td class="a-left">
                                    <asp:Label ID="Label1" Text="Transferor TIN No" class="bold" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblTransferreeTinNo" runat="server" meta:resourcekey="lblTransferreeTinNoResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="Label3" Text="Transferree TIN No:" class="bold" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblTransferorTinNo" runat="server" meta:resourcekey="lblTransferorTinNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="trDLNo" class="hide" style="display: none;">
                                <td class="a-left">
                                    <asp:Label ID="Label5" Text="Transferor DL No" class="bold" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblTransferreeDLNO" runat="server" meta:resourcekey="lblTransferreeDLNOResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="Label7" Text="Transferree DL No:" class="bold" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblTransferorDLNO" runat="server" meta:resourcekey="lblTransferorDLNOResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseBy" runat="server">
                                <td class="a-left">
                                    <asp:Label ID="LabelIndentRaiseBy" Text="Indent Raise By" class="bold" runat="server"
                                        meta:resourcekey="LabelIndentRaiseByResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblRaiseBy" runat="server" meta:resourcekey="lblRaiseByResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="LabelStatus" Text="Status :" class="bold" runat="server" meta:resourcekey="LabelStatusResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseFrom" runat="server">
                                <td class="a-left">
                                    <asp:Label ID="LabelIndentRaisedFrom" Text="Indent Raised From" class="bold" runat="server"
                                        meta:resourcekey="LabelIndentRaisedFromResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblIndentRaiseTo" runat="server" meta:resourcekey="lblIndentRaiseToResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="LabelIndentReceivedNo" Text="Indent ReceivedNo :" class="bold" runat="server"
                                        meta:resourcekey="LabelIndentReceivedNoResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblIndentReceivedNo" runat="server" meta:resourcekey="lblIndentReceivedNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="LabelIndentFrom" Text="Indent Raised To " class="bold" runat="server"
                                        meta:resourcekey="LabelIndentFromResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblIndentFrom" runat="server" meta:resourcekey="lblIndentFromResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblissueddatetitle" class="bold" runat="server" meta:resourcekey="lblissueddatetitleResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblIssuedDate" runat="server" meta:resourcekey="lblIssuedDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseComment" runat="server">
                                <td class="a-left">
                                    <asp:Label ID="LabelComments" Text="Comments:" class="bold" runat="server" meta:resourcekey="LabelCommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td>
                                    <asp:Label ID="lblComments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label></strong>
                                </td>
                                <td class="a-right">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                            AutoGenerateColumns="False" CssClass="gridView w-100p" PageSize="20" OnRowDataBound="GridViewDetails_RowDataBound"
                            meta:resourcekey="gvSalesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." meta:resourcekey="SLNoTemplateFieldResource1">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField runat="server" ID="hdnStockReceived" Value='<%# bind("StockReceived") %>' />
                                        <asp:HiddenField runat="server" ID="hdnStockPartRec" Value='<%# bind("RECQuantity") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSellingPrice" Value='<%# bind("SellingPrice") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource8" />
                                <asp:BoundField DataField="CategoryName" HeaderText="Category" meta:resourcekey="BoundFieldResource5" />
                                <asp:BoundField DataField="BatchNo" HeaderText="Batch No" HeaderStyle-CssClass="a-center"
                                    meta:resourcekey="BoundFieldResource6" >
<HeaderStyle CssClass="a-center"></HeaderStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Expiry Date" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" :GetDate(DataBinder.Eval(Container.DataItem, "ExpiryDate", "{0:MMM-yy}").ToString())%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ordered Qty" meta:resourcekey="TemplateFieldResource13"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity")) / Convert.ToInt32(Eval("OrderedConvertUnit"))))+" ("+Eval("OrderedUnit")+")" %>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Raised Qty (LSU)" meta:resourcekey="TemplateFieldResource14"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity")))) + " (" + Eval("SellingUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issued Qty" meta:resourcekey="TemplateFieldResource15"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("StockReceived")) / Convert.ToInt32(Eval("OrderedConvertUnit")))) + " (" + Eval("OrderedUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issued Qty(Lsu)" meta:resourcekey="TemplateFieldResource16"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("StockReceived")))) + " (" + Eval("SellingUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Previous Received Quantity" meta:resourcekey="TemplateFieldResource21"
                                    Visible="false" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("StockDamage")) / Convert.ToInt32(Eval("OrderedConvertUnit")))) + " (" + Eval("OrderedUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Previous Received Qty(Lsu)" meta:resourcekey="TemplateFieldResource22"
                                    Visible="false">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("StockDamage")))) + " (" + Eval("SellingUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Quantity" meta:resourcekey="TemplateFieldResource17"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("RECQuantity")) / Convert.ToInt32(Eval("OrderedConvertUnit")))) + " (" + Eval("OrderedUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Qty(Lsu)" meta:resourcekey="TemplateFieldResource18"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0}", Convert.ToInt32(Eval("RECQuantity")))) + " (" + Eval("SellingUnit") + ")"%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Issued Qty Amount" 
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource23">
                                    <ItemTemplate>
                                      <%# (String.Format("{0:n}", Convert.ToDecimal(Eval("StockReceived")) * Convert.ToDecimal(Eval("SellingPrice"))))%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Cost Price <br /> and Selling Price <br /> of the Product" meta:resourcekey="TemplateFieldResource19"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%# (String.Format("{0:n}", Convert.ToDecimal(Eval("RECQuantity")) * Convert.ToDecimal(Eval("SellingPrice"))))%>
                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td class="a-right bold paddingR20">
                        <asp:Label runat="server" ID="lblIssuedAmount" Text="Total Issued Amount: " meta:resourcekey="lblIssuedAmountResource1"></asp:Label>
                        <asp:Label runat="server" ID="lblDisplayIssuedAmount" Text="0" meta:resourcekey="lblDisplayIssuedAmount"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-right bold paddingR20">
                        <asp:Label runat="server" ID="lbltotalText" Text="Total Received Amount: " meta:resourcekey="lbltotalTextResource1"></asp:Label>
                        <asp:Label runat="server" ID="lblTotalAmount" Text="0" meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table runat="server" id="tdApproved" class="w-100p">
                <tr class="bold">
                    <td>
                        <%=Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_08%>
                    </td>
                    <td id="approvedDateTD" class="w-80p a-left" runat="server">
                    </td>
                </tr>
                <tr class="bold">
                    <td>
                        <%=Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_09%>
                        &nbsp;&nbsp; :
                    </td>
                    <td id="approvedByTD" class="a-left w-80p" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Rs_PageTotal" Text="0" runat="server" class="hide" meta:resourcekey="lblVat13Resource1"></asp:Label>
                        <asp:Label ID="lblUnitCostPrice" Text="0" runat="server" class="hide" meta:resourcekey="lblVat0Resource2"></asp:Label>
                        <asp:Label ID="lblTSellingPrice" Text="0" runat="server" class="hide" meta:resourcekey="lblVatothersResource2"></asp:Label>
                        <asp:Label ID="lblTotal" class="hide" runat="server" Text="0" meta:resourcekey="lblTotalResource1"></asp:Label>
                        <asp:Label ID="lblTotalQty" class="hide" runat="server" Text="0" meta:resourcekey="lblTotalQtyResource1"></asp:Label>
                        <asp:Label ID="lblTotalUnitSellingPrice" class="hide" runat="server" Text="0" meta:resourcekey="lblTotalQtyResource1"></asp:Label>
                        <asp:Label ID="lblTotalPrice" class="hide" runat="server" Text="0" meta:resourcekey="lblTotalPriceResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <table class="w-95p">
            <tr>
                <td class="a-center" id="tdBtns">
                    <asp:Button CssClass="btn" ID="btnExportExcel" runat="server" Text="Export to Excel"
                        OnClick="btnExportExcel_Click" meta:resourcekey="btnExportExcelResource1" />
                    &nbsp;
                    <asp:Button ID="btnPrint" OnClientClick="doPrint();return false;" runat="server"
                        CssClass="btn" Text="Print" meta:resourcekey="btnPrintResource1" />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn"
                        Text="Back" meta:resourcekey="btnBackResource1" />
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnEnablePackSize" runat="server" />
    <input type="hidden" id="hdnXsltPrint" runat="server" value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">

        var errorMsg = SListForAppMsg.Get('StockIntend_Error') == null ? "Alert" : SListForAppMsg.Get('StockIntend_Error');
        var informMsg = SListForAppMsg.Get('StockIntend_Information') == null ? "Information" : SListForAppMsg.Get('StockIntend_Information');
        var okMsg = SListForAppMsg.Get('StockIntend_Ok') == null ? "Ok" : SListForAppMsg.Get('StockIntend_Ok')
        var cancelMsg = SListForAppMsg.Get('StockIntend_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_Cancel');
        var userMsg;
        function ValidateReturnQty(IssuedQuantity, ReturnQuantity) {

            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;

            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {
                var userMsg = SListForAppMsg.Get("StockIntend_ViewIssuedIndentdetails_aspx_01") == null ? "Provide return quantity less than or equal to issued quantity" : SListForAppMsg.Get("StockIntend_ViewIssuedIndentdetails_aspx_01")
                ValidationWindow(userMsg, errorMsg);
                return false;

                // }
                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
      
    </script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "31/12/9999" && Date != "12/31/9999" && Date != "Dec-99")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }  
       
    </script>

    <script type="text/javascript" language="javascript">

        function doPrint() {

//            var headstr = "<html><head></head><body>";
//            var footstr = "</body>";
//            var oldstr = document.body.innerHTML;
//            $('#tblIndentInfo').addClass('removewraping');
//            if ($('#hdnXsltPrint').val() == "Y") {
//                var newstr = document.all.item('divXsltPrint').innerHTML;
//            }
//            else {
//                var newstr = document.all.item('divProjection').innerHTML;
//            }
//            document.body.innerHTML = headstr + newstr + footstr;
//            window.print();
//            document.body.innerHTML = oldstr;

            //var prtContent = document.getElementById('PrintDischarge');
            if ($('#hdnXsltPrint').val() == "Y") {
                var prtContent = document.getElementById('divXsltPrint');
            }
            else {
                var prtContent = document.getElementById('divProjection');
            }
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<style>.hide{display: none;}</style>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
            }, 1000);
            
           }

        function CheckRow(id) {

            var textid = (document.getElementById(id).id).split('_');


            // var txtQty= document.getElementById('hdnpQuantity').value;

            //  document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct').checked = true;


        }

        function Getqty() {


        }

        
    </script>

</body>
</html>
