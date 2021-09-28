<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubStoreReturnDetail.aspx.cs"
    Inherits="StockIntend_SubStoreReturnDetail" meta:resourcekey="PageResource1"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>SubStore Detail</title>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divProjection" runat="server">
            <table class="a-center w-100p">
                <tr>
                    <td class="a-center" colspan="4">
                        <asp:Image ID="imgBillLogo" runat="server" CssClass="hide" meta:resourcekey="imgBillLogoResource1" />
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" meta:resourcekey="lblstreetResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblDate1" runat="server" Font-Bold="True" Text="Date  " meta:resourcekey="lblDate1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll1" runat="server" meta:resourcekey="lblll1Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblIndentRaiseBy" runat="server" Font-Bold="True" Text="Sub Store Return By  "
                                                    meta:resourcekey="lblIndentRaiseByResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll2" runat="server" meta:resourcekey="lblll2Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblRaiseBy" runat="server" meta:resourcekey="lblRaiseByResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Sub Store Return To "
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll3" runat="server" meta:resourcekey="lblll3Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblIndentRaiseTo" runat="server" meta:resourcekey="lblIndentRaiseToResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblIndentRaisedTo" runat="server" Font-Bold="True" Text="Sub Store Return From"
                                                    meta:resourcekey="lblIndentRaisedToResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll4" runat="server" meta:resourcekey="lblll4Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblIndentFrom" runat="server" meta:resourcekey="lblIndentFromResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblIndentNo1" runat="server" Font-Bold="True" Text="Return No " meta:resourcekey="lblIndentNo1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll5" runat="server" meta:resourcekey="lblll5Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblIntendNo" runat="server" meta:resourcekey="lblIntendNoResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblStatus1" runat="server" Font-Bold="True" Text="Status" meta:resourcekey="lblStatus1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblll6" runat="server" meta:resourcekey="lblll6Resource1">:</asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                            Visible="False" AutoGenerateColumns="False" CssClass="gridView w-100p" OnRowDataBound="GridViewDetails_RowDataBound"
                            meta:resourcekey="GridViewDetailsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1"
                                    ItemStyle-CssClass="w-5p">
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
                                        <asp:HiddenField ID="hdnExp" runat="server" Value='<%# bind("ExpiryDate") %>' />
                                        <asp:HiddenField ID="hdnProductReceivedDetailsId" runat="server" Value='<%# bind("ProductReceivedDetailsID") %>' />
                                        <asp:HiddenField ID="hdnReceivedUniqueNumber" runat="server" Value='<%# bind("ReceivedUniqueNumber") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product" ItemStyle-HorizontalAlign="left"
                                    meta:resourcekey="BoundFieldResource1">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" meta:resourcekey="BoundFieldResource2">
                                </asp:BoundField>
                                <%--<asp:BoundField DataField="Quantity" HeaderText="RaisedQuantity" ItemStyle-HorizontalAlign="Right"
                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>--%>
                                <asp:TemplateField HeaderText="Return Quantity" ItemStyle-HorizontalAlign="Right"
                                    ItemStyle-CssClass="w-16p" Visible="False" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRaisedquantity" runat="server" onblur="Checkraiseqty(this.id);" CssClass="paddingR10 w-80"
                                            onkeypress="return ValidateSpecialAndNumeric(this);"
                                            Text='<%# bind("Quantity") %>' meta:resourcekey="txtRaisedquantityResource1"></asp:TextBox>
                                       <%-- <asp:Label ID="lblRaisedquantity" runat="server" Text='<%# bind("Quantity") %>'
                                            CssClass="show a-right" meta:resourcekey="lblRaisedquantityResource1"></asp:Label>--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="StockReceived" HeaderText="Issued Quantity"
                                    meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="RECQuantity" HeaderText=" Received Quantity" meta:resourcekey="BoundFieldResource5">
                                </asp:BoundField>
                                <asp:BoundField DataField="SellingUnit" HeaderText="SellingUnit" ItemStyle-HorizontalAlign="left"
                                    meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="FromInHandQuantity" ItemStyle-HorizontalAlign="left" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <%--  <asp:TemplateField HeaderText="Select" >
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkProduct" runat="server"  Visible ="false" />
                                                              <asp:HiddenField ID="hdnProductID" runat="server" Value='<%#Eval("ProductID") %>' />
                                                                <asp:HiddenField ID="hdnID" runat="server" Value='<%#Eval("ID") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                <%-- <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>--%>
                                <asp:BoundField DataField="ToInHandQuantity" HeaderText="InHandQuantity" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldResource7">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                        <asp:GridView ID="gvIntendDetail" EmptyDataText="No matching records found " runat="server"
                            OnRowDataBound="gvIntendDetail_RowDataBound" AutoGenerateColumns="False" CssClass="gridView w-100p"
                            meta:resourcekey="gvIntendDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource2">
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
                                <asp:BoundField DataField="ProductName" HeaderText="Product" meta:resourcekey="BoundFieldResource7">
                                </asp:BoundField>
                                <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" meta:resourcekey="BoundFieldResource8">
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="IntendRaisedQuantity" meta:resourcekey="BoundFieldResource9">
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="RecQuantity" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                    meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtquantity" runat="server" CssClass="paddingR10 w-60"
                                            onkeypress="if(ValidateSpecialAndNumeric(this)) return CheckRow(this.id);"
                                            meta:resourcekey="txtquantityResource1"></asp:TextBox>
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
                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewIntendDetail_ApprovedDate%>--%>
                        <asp:Label ID="lblApprovedDate" runat="server" Text="Approved Date" meta:resourcekey="lblApprovedDateResource1"></asp:Label>
                    </td>
                    <td id="approvedDateTD" class="w-80 a-left" runat="server">
                    </td>
                </tr>
                <tr class="bold">
                    <td>
                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewIntendDetail_ApprovedBy%>--%>
                        <asp:Label ID="lblApprovedBy" runat="server" Text="Approved By" meta:resourcekey="lblApprovedByResource1"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:Label ID="lblll7" runat="server" meta:resourcekey="lblll7Resource1">:</asp:Label>
                    </td>
                    <td id="approvedByTD" class="w-80 a-left" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <table class="w-100p">
            <tr>
                <td class="a-center" id="tdBtns">
                    <asp:Button ID="btnApprove" Visible="False" Text=" Approve Return " runat="server"
                        CssClass="btn"
                        CommandArgument="ApproveIntend" OnClick="btnIntend_Click" OnClientClick="javascript:return CheckZero();"
                        meta:resourcekey="btnApproveResource1" />
                    &nbsp;&nbsp;
                    <asp:Button Visible="False" ID="btnCancelIntend" Text=" Cancel Return " runat="server"
                        CssClass="cancel-btn" CommandArgument="CancelIntend" OnClick="btnCancelIntend_Click"
                        meta:resourcekey="btnCancelIntendResource1" />
                    &nbsp;&nbsp;
                    <%--     <asp:Button ID="btnSave" Text="Save" Visible ="false"  runat="server" onmouseover="this.className='btn btnhov'"
                                        CssClass="btn" onmouseout="this.className='btn'" onclick="btnSave_Click" 
                                       /> &nbsp;&nbsp;--%>
                    <asp:Button ID="btnPrint" runat="server" OnClientClick="doPrint();return false;"
                        CssClass="btn" Text=" Print " meta:resourcekey="btnPrintResource1" />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn"
                        Text="Back" meta:resourcekey="btnBackResource1" />
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnFromLocationID" runat="server" />
        <input type="hidden" id="hdnUserID" runat="server" />
        <input id="hdnProductList" runat="server" type="hidden" value="" />
        <input id="hdnRaiseqty" runat="server" type="hidden" value="" />
    </div>
    <Attune:Attunefooter ID="Attunefooter1" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function ValidateReturnQty(IssuedQuantity, ReturnQuantity) {

            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;

            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {

                var userMsg = SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_01") == null ? "Provide return quantity less than or equal to issued quantity" : SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;

                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
    </script>

    <script type="text/javascript" language="javascript">
    
        var errorMsg = SListForAppMsg.Get('StockIntend_Error') == null ? "Alert" : SListForAppMsg.Get('StockIntend_Error');
        var informMsg = SListForAppMsg.Get('StockIntend_Information') == null ? "Information" : SListForAppMsg.Get('StockIntend_Information');
        var okMsg = SListForAppMsg.Get('StockIntend_Ok') == null ? "Ok" : SListForAppMsg.Get('StockIntend_Ok')
        var cancelMsg = SListForAppMsg.Get('StockIntend_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_Cancel');
        var userMsg;
        function doPrint() {

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //document.getElementById('tdBtns').style.display = "none";
            $('#tdBtns').removeClass().addClass('hide');
            //            $('#<%=GridViewDetails.ClientID %>').find('span[id$="lblRaisedquantity"]').show();
            //$('#<%=GridViewDetails.ClientID %>').find('input:text[id$="txtRaisedquantity"]').hide();
            $('#<%=GridViewDetails.ClientID %>').find('input:text[id$="txtRaisedquantity"]').show();
            WinPrint.document.write(document.getElementById('divProjection').innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            //$('#<%=GridViewDetails.ClientID %>').find('span[id$="lblRaisedquantity"]').hide();
            //$('#<%=GridViewDetails.ClientID %>').find('input:text[id$="txtRaisedquantity"]').show();
            //document.getElementById('tdBtns').style.display = "Block";
            $('#tdBtns').removeClass().addClass('displaytd a-center');

        }

        function CheckRow(id) {

            var textid = (document.getElementById(id).id).split('_');


            // var txtQty= document.getElementById('hdnpQuantity').value;

            //  document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct').checked = true;


        }

        function Getqty() {


        }
        function Checkraiseqty(txtId) {

            var lblrisedquantity = txtId.replace("txtRaisedquantity", "lblRaisedquantity");
            var txtchangedqty = document.getElementById(txtId).value;
            var Orgionalqty = document.getElementById(lblrisedquantity).innerHTML;
            if (Number(txtchangedqty) > Number(Orgionalqty)) {
                var userMsg = SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_02") == null ? "Given quantity more the raised quantity" : SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById(txtId).value = Number(Orgionalqty);

            }
            return false;
        }
        function CheckZero() {

            var count = 0;
            var grid = document.getElementById('GridViewDetails');
            for (var i = 2; i <= grid.rows.length; i++) {

                var s = grid.id + '_ctl0' + [i]

                var qty = document.getElementById(s + '_txtRaisedquantity').value;
                if (qty > 0) {
                    count += count + 1;
                }
            }
            if (count <= 0) {
                var userMsg = SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_03") == null ? "All the product return quantity is zero.You can use cancel option!" : SListForAppMsg.Get("StockIntend_SubStoreReturnDetail_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            return true;
        }

        //        function ValidateQty(obj,s) {
        //            alert(s);
        //            var textid1 = document.getElementById(obj).split('_');
        //            //var Qty = document.getElementById(textid1[0] + '_' + textid1[1] + '_hdnpQuantity').value;
        //            var New = document.getElementById(s).value;
        //            alert(Qty);
        //            var New = document.getElementById(s).value;
        //           // var textid = document.getElementById(obj).split('_');
        //            alert(New);

        //            //document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct')
        ////            var textid1 = document.getElementById(id).innerHTML;
        //           
        ////            if (document.getElementById('hdnQuantity').value == "") {
        ////            document.getElementById('hdnQuantity').value =0;
        ////            }
        ////            else{

        ////            getElementById('hdnQuantity').value = document.getElementById(textid1[0] + '_' + textid1[1] + '_txtquantity').value;
        ////            var qty = document.getElementById('hdnQuantity').value;
        ////            alert(qty);
        ////            
        //        }
        
    </script>

</body>
</html>
