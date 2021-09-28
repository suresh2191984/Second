<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewSubStoreStockdetails.aspx.cs"
    Inherits="StockIntend_ViewSubStoreStockdetails" EnableEventValidation="false"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Sub Store Stock View</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divProjection" runat="server">
            <table class="searchPanel w-100p">
                <tr>
                    <td class="a-center">
                        <asp:Image ID="imgBillLogo" runat="server" meta:resourcekey="imgBillLogoResource1" />
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
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
                        <table class="w-100p" runat="server" id="tblIndentInfo">
                            <tr>
                                <td class="w-13p a-left">
                                    <strong>
                                        <asp:Label ID="LabelIndentNo" Text="Return No :" runat="server" CssClass="bold" meta:resourcekey="LabelIndentNoResource1"></asp:Label></strong>
                                </td>
                                <td class="w-50p a-left">
                                    <asp:Label ID="lblIntendNo" runat="server" meta:resourcekey="lblIntendNoResource1"></asp:Label>
                                </td>
                                <td class="w-12p a-left">
                                    <strong>
                                        <asp:Label ID="LabelDate" Text="Return Date :" runat="server" CssClass="bold" meta:resourcekey="LabelDateResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="trTransferorNo" class="hide">
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="Label1" Text="Transferor TIN No:" runat="server" CssClass="bold" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblTransferreeTinNo" runat="server" meta:resourcekey="lblTransferreeTinNoResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="Label3" Text="Transferree TIN No:" runat="server" CssClass="bold"
                                            meta:resourcekey="Label3Resource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblTransferorTinNo" runat="server" meta:resourcekey="lblTransferorTinNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="trDLNo" class="hide">
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="Label5" Text="Transferor DL No:" runat="server" CssClass="bold" meta:resourcekey="Label5Resource1"></asp:Label>
                                    </strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblTransferreeDLNO" runat="server" meta:resourcekey="lblTransferreeDLNOResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="Label7" Text="Transferree DL No:" runat="server" CssClass="bold" meta:resourcekey="Label7Resource1"></asp:Label>
                                    </strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblTransferorDLNO" runat="server" meta:resourcekey="lblTransferorDLNOResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseBy" runat="server">
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelIndentRaiseBy" Text="Sub Store Return Raise By:" CssClass="bold"
                                            runat="server" meta:resourcekey="LabelIndentRaiseByResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblRaiseBy" runat="server" meta:resourcekey="lblRaiseByResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelStatus" Text="Status :" runat="server" CssClass="bold" meta:resourcekey="LabelStatusResource1"></asp:Label>
                                    </strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseFrom" runat="server">
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelIndentRaisedFrom" Text="Sub Store Return To:" CssClass="bold"
                                            runat="server" meta:resourcekey="LabelIndentRaisedFromResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblIndentRaiseTo" runat="server" meta:resourcekey="lblIndentRaiseToResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelIndentReceivedNo" Text="Return Received No :" CssClass="bold"
                                            runat="server" meta:resourcekey="LabelIndentReceivedNoResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblIndentReceivedNo" runat="server" meta:resourcekey="lblIndentReceivedNoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelIndentFrom" Text="Sub Store Return From :" CssClass="bold" runat="server"
                                            meta:resourcekey="LabelIndentFromResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblIndentFrom" runat="server" meta:resourcekey="lblIndentFromResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="lblissueddatetitle" runat="server" CssClass="bold" meta:resourcekey="lblissueddatetitleResource1"></asp:Label>
                                    </strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblIssuedDate" runat="server" meta:resourcekey="lblIssuedDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trRaiseComment" runat="server">
                                <td class="a-left">
                                    <strong>
                                        <asp:Label ID="LabelComments" Text="Comments:" runat="server" CssClass="bold" meta:resourcekey="LabelCommentsResource1"></asp:Label></strong>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblComments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                </td>
                                <td class="a-right" colspan="2">
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
                            ShowFooter="True" meta:resourcekey="gvSalesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource11">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                                    <FooterStyle ></FooterStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product Name"
                                    meta:resourcekey="BoundFieldResource8">
                                                    
                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="CategoryName" HeaderText="CATEGORY" >
                                                    <FooterStyle ></FooterStyle>
                                                </asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="CATEGORY" FooterStyle-Font-Bold="true" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <div class="a-left">
                                            <asp:Label ID="lblCategory" Text='<%# Eval("CategoryName") %>' runat="server" meta:resourcekey="lblCategoryResource1"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lbltotall1" runat="server" meta:resourcekey="lbltotall1Resource1">Total</asp:Label>
                                    </FooterTemplate>
<FooterStyle  Font-Bold="True"></FooterStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="BatchNo" FooterStyle-Font-Bold="true" 
                                    meta:resourcekey="TemplateFieldResource1" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle CssClass="dataheader1" Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Expiry Date" Visible="false" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ExpiryDate", "{0:MMM-yy}").ToString())%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="10%" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                    <FooterTemplate>
                                        <asp:Label ID="lbltotall2" runat="server" meta:resourcekey="lbltotall2Resource1">Total</asp:Label>
                                    </FooterTemplate>
                                                    <FooterStyle  HorizontalAlign="Center"></FooterStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Return Quantity" FooterStyle-Font-Bold="true"
                                    meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" Text='<%# Eval("Quantity") %>' runat="server" meta:resourcekey="lblRECBillIDResource1"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <%# lblTotalQty.Text %>
                                    </FooterTemplate>
                                                    <FooterStyle  Font-Bold="True" HorizontalAlign="Right"></FooterStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                              <asp:TemplateField HeaderText="SellingUnit" FooterStyle-Font-Bold="true" 
                                    meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSellingUnit" Text='<%# Eval("SellingUnit") %>' runat="server" meta:resourcekey="lblVat12Resource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                                    <FooterStyle  Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SellingPrice" FooterStyle-Font-Bold="true" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblSellingPrice" Text='<%# Eval("SellingPrice") %>' runat="server" meta:resourcekey="lblVat12Resource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                                    <FooterStyle  Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" FooterStyle-Font-Bold="true" >
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotAmt" runat="server" meta:resourcekey="lblVat12Resource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                                    <FooterStyle  Font-Bold="True"></FooterStyle>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                        <asp:Label ID="Rs_PageTotal" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat13Resource1"></asp:Label>
                        <asp:Label ID="lblUnitCostPrice" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat0Resource2"></asp:Label>
                        <asp:Label ID="lblTSellingPrice" Text="0" runat="server" Visible="False" meta:resourcekey="lblVatothersResource2"></asp:Label>
                        <asp:Label ID="lblTotal" Visible="false" runat="server" Text="0" meta:resourcekey="lblTotalResource1"></asp:Label>
                        <asp:Label ID="lblTotalQty" Visible="false" runat="server" Text="0" meta:resourcekey="lblTotalQtyResource1"></asp:Label>
                        <asp:Label ID="lblTotalUnitSellingPrice" Visible="false" runat="server" Text="0" meta:resourcekey="lblTotalQtyResource1"></asp:Label>
                        <asp:Label ID="lblTotalPrice" Visible="false" runat="server" Text="0" meta:resourcekey="lblTotalPriceResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvIntendDetail" EmptyDataText="No matching records found " runat="server"
                            OnRowDataBound="gvIntendDetail_RowDataBound" AutoGenerateColumns="False" CssClass="gridView w-100p"
                            meta:resourcekey="gvIntendDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnCategoryId" runat="server" Value='<%# bind("CategoryId") %>' />
                                        <asp:HiddenField ID="hdnTax" runat="server" Value='<%# bind("Tax") %>' />
                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" Value='<%# bind("SellingUnit") %>' />
                                        <asp:HiddenField ID="hdnUnitPrice" runat="server" Value='<%# bind("UnitPrice") %>' />
                                        <asp:HiddenField ID="hdnSellingPrice" runat="server" Value='<%# bind("SellingPrice") %>' />
                                        <asp:HiddenField ID="hdnInvoiceQty" runat="server" Value='<%# bind("InvoiceQty") %>' />
                                        <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpID" runat="server" Value='<%# bind("ID") %>' />
                                        <asp:HiddenField ID="hdnpProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnpQuantity" runat="server" Value='<%# bind("Quantity") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product" meta:resourcekey="BoundFieldResource1">
                                </asp:BoundField>
                                <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" meta:resourcekey="BoundFieldResource2">
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="IntendRaisedQuantity" meta:resourcekey="BoundFieldResource3">
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="RecQuantity" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                    meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtquantity" runat="server" CssClass="paddingR10 w-60"
                                            onkeypress="return ValidateSpecialAndNumeric(this) && CheckRow(this.id);" meta:resourcekey="txtquantityResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnQuantity" runat="server" Value="0" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                </asp:TemplateField>
                                <%--  <asp:TemplateField HeaderText="Select" >
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkProduct" runat="server"  Visible ="false" />
                                                              <asp:HiddenField ID="hdnProductID" runat="server" Value='<%#Eval("ProductID") %>' />
                                                                <asp:HiddenField ID="hdnID" runat="server" Value='<%#Eval("ID") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                <%-- <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>--%>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table runat="server" id="tdApproved" class="w-100p">
                <tr class="bold">
                    <td>
                        <%=Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_08%>
                    </td>
                    <td id="approvedDateTD" class="w-80p a-left" runat="server">
                    </td>
                </tr>
                <tr class="bold">
                    <td>
                        <%=Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_09%>
                        &nbsp;&nbsp; :
                    </td>
                    <td id="approvedByTD" class="w-80p a-left" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <table class="w-95p">
            <tr>
                <td class="a-center" id="tdBtns">
                    <asp:Button ID="btnApprove" Visible="False" Text="Approve Indent" runat="server"
                        CssClass="btn" CommandArgument="ApproveIntend" OnClick="btnIntend_Click" meta:resourcekey="btnApproveResource1" />
                    &nbsp;&nbsp;
                    <asp:Button Visible="False" ID="btnCancelIntend" Text="Cancel Indent" runat="server"
                        CssClass="cancel-btn" CommandArgument="CancelIntend" OnClick="btnIntend_Click" meta:resourcekey="btnCancelIntendResource1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnSave" Text="Save" Visible="False" runat="server"
                        CssClass="btn" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                    &nbsp;&nbsp;
                    <asp:Button CssClass="btn" ID="btnExportExcel" runat="server" Text="Export to Excel"
                        OnClick="btnExportExcel_Click" meta:resourcekey="btnExportExcelResource1" />
                    &nbsp;
                    <asp:Button ID="btnPrint" OnClientClick="doPrint();return false;" runat="server"
                        CssClass="btn" Text="Print" meta:resourcekey="btnPrintResource1" />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn" Text="Back" Visible="false"
                        meta:resourcekey="btnBackResource1" />
                </td>
            </tr>
        </table>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

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
        var errorMsg = SListForAppMsg.Get('StockIntend_Error') == null ? "Alert" : SListForAppMsg.Get('StockIntend_Error');
        var informMsg = SListForAppMsg.Get('StockIntend_Information') == null ? "Information" : SListForAppMsg.Get('StockIntend_Information');
        var okMsg = SListForAppMsg.Get('StockIntend_Ok') == null ? "Ok" : SListForAppMsg.Get('StockIntend_Ok')
        var cancelMsg = SListForAppMsg.Get('StockIntend_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_Cancel');

        //        function doPrint() {
        //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta&#65533;tus=0');
        //            document.getElementById('tdBtns').style.display = "none";
        //            WinPrint.document.write(document.getElementById('divProjection').innerHTML);
        //            WinPrint.document.close();
        //            WinPrint.focus();
        //            WinPrint.print();
        //            //WinPrint.close();
        //            document.getElementById('tdBtns').style.display = "Block";

        //        }

        function doPrint() {

            var headstr = "<html><head></head><body>";
            var footstr = "</body>";
            var oldstr = document.body.innerHTML;
            $('#tblIndentInfo').addClass('removewraping');
            var newstr = document.all.item('divProjection').innerHTML;
            document.body.innerHTML = headstr + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;

        }

        function CheckRow(id) {

            var textid = (document.getElementById(id).id).split('_');


            // var txtQty= document.getElementById('hdnpQuantity').value;

            //  document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct').checked = true;


        }

        function Getqty() {


        }

        
    </script>

    <script language="javascript" type="text/javascript">
        var userMsg;
        function ValidateReturnQty(IssuedQuantity, ReturnQuantity) {

            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;

            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {

                var userMsg = SListForAppMsg.Get("StockIntend_ViewSubStoreStockdetails_aspx_01") == null ? "Provide return quantity less than or equal to issued quantity" : SListForAppMsg.Get("StockIntend_ViewSubStoreStockdetails_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
      
    </script>

</body>
</html>
