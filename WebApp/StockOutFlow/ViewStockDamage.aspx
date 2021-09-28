<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewStockDamage.aspx.cs"
    Inherits="StockOutFlow_ViewStockDamage" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader id="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divdamage">
            <table class="w-100p a-left">
                <tr>
                    <td colspan="5" class="a-center">
                        <asp:Image ID="imgBillLogo" runat="server" class="hide a-center" meta:resourcekey="imgBillLogoResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="a-center h-25 bold font12">
                        <asp:Label ID="lblStockDamage" runat="server" Text="Stock Damage" meta:resourcekey="lblStockDamageResource1"></asp:Label>
                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_StockDamage%>--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="paddingL30 h-25 a-left bold font12">
                        <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="h-15">
                    <td class="paddingL30 w-25p">
                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                    </td>
                    <td class="w-45p">&nbsp;</td>
                    <td class="a-left w-7p" >
                        <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource11"></asp:Label>
                        <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_Date%>--%>
                    </td>
                    <td>
                    :
                    </td>
                    <td class="a-left bold" >
                        &nbsp;<asp:Label ID="lblSDDate" runat="server" meta:resourcekey="lblSDDateResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="h-15">
                    <td class="paddingL30">
                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                    </td>
                    <td >&nbsp;</td>
                    <td class="a-left ">
                        <asp:Label ID="lblStockDamageNo" runat="server" Text="Stock Damage No" meta:resourcekey="lblStockDamageNoResource11"></asp:Label>
                        <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_StockDamageNo%>--%>
                    </td>
                     <td>
                    :
                    </td>
                    <td class="a-left bold">
                        &nbsp;
                        <asp:Label ID="lblSDID" runat="server" meta:resourcekey="lblSDIDResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="h-15">
                    <td class="paddingL30">
                        <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                    </td>
                    <td >&nbsp;</td>
                    <td class="a-left ">
                        <asp:Label ID="lblStatus2" runat="server" meta:resourcekey="lblStatus2Resource11">Status</asp:Label>
                        <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_Status%>--%>
                    </td>
                     <td>
                    :
                    </td>
                    <td class="a-left bold">
                        &nbsp;
                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:GridView ID="grdResult" CssClass="gridView w-100p" EmptyDataText="No matching records found "
                            runat="server" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                            CellPadding="2" CellSpacing="1" DataKeyNames="ProductKey" meta:resourcekey="grdResultResource1">
                            <PagerStyle HorizontalAlign="Center"/>
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpProductKey" runat="server" Value='<%# bind("ProductKey") %>' />
                                        <asp:HiddenField ID="hdnpParentProductID" runat="server" Value='<%# bind("ParentProductID") %>' />
                                        <asp:HiddenField ID="hdnpInHandQuantity" runat="server" Value='<%# bind("InHandQuantity") %>' />
                                        <asp:HiddenField ID="hdnpUnits" runat="server" Value='<%# bind("Unit") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="true" ItemStyle-Width="20%"
                                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderText="SRD No"
                                                    DataField="Description" />--%>
                                <asp:BoundField HeaderText="Product Code" DataField="ProductCode" meta:resourcekey="BoundFieldProduceCode1" />                                                    
                                <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="true" ItemStyle-Width="20%"
                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderText="Product Name"
                                    DataField="ProductName" meta:resourcekey="BoundFieldResource1">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="True" Width="20%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Batch No" DataField="BatchNo" Visible="True" meta:resourcekey="BoundFieldResource2" />
                                <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:TextBox Text='<%# Eval("Quantity","{0:N}") %>' Width="60px" ID="txtQuantity" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Inhand Qty" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("InHandQuantity","{0:N}") %>' Width="40px" ID="lblInHandQty" runat="server"
                                            meta:resourcekey="lblInHandQtyResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- <asp:TemplateField HeaderText="Units">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlUnit" runat="server" Width="70px">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnUnit" Value='<%# Eval("Unit") %>' runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                <asp:BoundField HeaderText="SellingUnit" DataField="Unit" meta:resourcekey="BoundFieldResource3" />
                                <asp:BoundField HeaderText="ProductKey" DataField="ProductKey" Visible="false" meta:resourcekey="BoundFieldResource4" />
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                        <%--<asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0"
                                            runat="server" ID="stockDamageDetailsTab" Width="82%">
                                        </asp:Table>--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:GridView ID="GridViewDetail" CssClass="gridView w-100p" EmptyDataText="No matching records found"
                            runat="server" AutoGenerateColumns="False" meta:resourcekey="GridViewDetailResource1">
                            <PagerStyle HorizontalAlign="Center"/>
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpProductKey" runat="server" Value='<%# bind("ProductKey") %>' />
                                        <asp:HiddenField ID="hdnpParentProductID" runat="server" Value='<%# bind("ParentProductID") %>' />
                                        <asp:HiddenField ID="hdnpInHandQuantity" runat="server" Value='<%# bind("InHandQuantity") %>' />
                                        <asp:HiddenField ID="hdnpUnits" runat="server" Value='<%# bind("Unit") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- <asp:BoundField HeaderText="SRD No" DataField="Description" />--%>
                                <asp:BoundField HeaderText="Product Code" DataField="ProductCode" meta:resourcekey="BoundFieldProduceCode1" /> 
                                <asp:BoundField HeaderText="Product Name" DataField="ProductName" meta:resourcekey="BoundFieldResource5" />
                                <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" Visible="True" meta:resourcekey="BoundFieldResource6" />
                                <asp:BoundField HeaderText="Selling Unit" DataField="Unit" meta:resourcekey="BoundFieldResource7" />
                                <asp:BoundField HeaderText="Return Quantity" DataField="Quantity" meta:resourcekey="BoundFieldResource8" DataFormatString="{0:N}" />
                                <asp:TemplateField HeaderText="Price Of Damaged Product" meta:resourcekey="BoundFieldDamagedProduct1">
                                    <ItemTemplate>
                                        <%# (String.Format("{0:n}", Convert.ToDecimal(Eval("Quantity")) * Convert.ToDecimal(Eval("SellingPrice"))))%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="a-center" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" id="commentsTD" runat="server">
                        <hr />
                    </td>
                </tr>
                <tr id="approvalTR" class="hide" runat="server">
                    <td colspan="5">
                        <table class="w-100p">
                            <tr>
                                <td class="bold w-18p">
                                    <asp:Label ID="lblApprovedDate" runat="server" Text="Approved Date" meta:resourcekey="lblApprovedDateResource1"></asp:Label>
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_ApprovedDate%>--%>
                                </td>
                                <td id="approvedDateTD" class="a-left " runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td class="bold w-18p"> 
                                    <asp:Label ID="lblApprovedBy" runat="server" Text="Approved By" meta:resourcekey="lblApprovedByResource1"></asp:Label>
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockDamage_ApprovedBy%>--%>
                                </td>
                                <td id="approvedByTD" class="a-left" runat="server">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <table class="w-100p" >
                            <tr>
                                <td id="tdApprove" runat="server">
                                    <asp:Button ID="btnApprove" Text="Approve" runat="server" 
                                        CssClass="btn" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource1" />
                                </td>
                                <td id="tdPrint" runat="server" class="a-center">
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                        runat="server" CssClass="btn" meta:resourcekey="btnPrintResource1" />
                                    <input type="hidden" id="hdnApproveStockDamage" runat="server" />
                                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn" Text="Back" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>

    <script language="javascript" type="text/javascript">
       
        function ValidateReturnQty(avilableQty, ReturnQuantity) {

//            var pavilableQty = document.getElementById(avilableQty).value;
            //            var pReturnQuantity = document.getElementById(ReturnQuantity).value;

            var pavilableQty = ToInternalFormat($('#'+avilableQty));
            var pReturnQuantity = ToInternalFormat($('#'+ReturnQuantity));


            if (Number(pavilableQty) < Number(pReturnQuantity)) {
                var userMsg = SListForAppMsg.Get('StockOutFlow_ViewStockDamage_aspx_01');
                var errorMsg = SListForAppMsg.Get('StockOutFlow_Error');
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                else {
                    ValidationWindow('Provide return quantity less than or equal to Available quantity','Error');
                    return false;

                }
                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
        //sathish
        $(document).ready(function() {
        if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ViewStockDamage') {
            $("#Attuneheader_TopHeader1_lblvalue").text('View Stock Damage');
            }
        });
    </script>
    
	<script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('divdamage');
            //document.getElementById('btnPrint').style.display = 'none';
            //document.getElementById('btnBack').style.display = 'none';
            $('#btnPrint').removeClass().addClass('hide');
            $('#btnBack').removeClass().addClass('hide');
            $('#btnApprove').removeClass().addClass('hide');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            WinPrint.document.close();
            WinPrint.focus();
            setTimeout(function() {
                WinPrint.print();
            }, 1000);
            //WinPrint.close();
            $('#btnPrint').removeClass().addClass('btn');
            $('#btnBack').removeClass().addClass('cancel-btn');
            $('#btnApprove').removeClass().addClass('btn');
        }
    </script>
</body>
</html>
