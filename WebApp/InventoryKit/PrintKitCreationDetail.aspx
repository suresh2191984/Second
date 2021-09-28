<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintKitCreationDetail.aspx.cs"
    Inherits="Inventory_PrintKitCreationDetail" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print KitCreation Detail View</title>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader id="Attuneheader" runat="server" />
    <div class="contentdata" id="divProjection">
        <div>
            <table class="w-100p">
             
                <tr>
                    <td class="a-center">
                        <h3>
                            <asp:Label ID="lblOrgName" runat="server" 
                                meta:resourcekey="lblOrgNameResource1"></asp:Label></h3>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-95p" border="0" cellpadding="4" cellspacing="2">
                            <tr>
                                <td class="a-left">
                                    <b><asp:Label ID="lblDateLiteral" runat="server" Text="Date :" meta:resourcekey="lblDateLiteralResource1"></asp:Label>
                                        <asp:Label ID="lblDate" runat="server" Font-Bold="True" 
                                        meta:resourcekey="lblDateResource1"></asp:Label></b>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="a-left">
                                    <strong><asp:Label ID="lblKitLiteral" runat="server" Text="Kit ProductName:" meta:resourcekey="lblKitLiteralResource1"></asp:Label>
                                        <asp:Label ID="lblKitID" Font-Bold="True" runat="server" 
                                        meta:resourcekey="lblKitIDResource1"></asp:Label>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <strong>
                                      <asp:Label ID="lblCommentsLiteral" runat="server" Text="Comments:" meta:resourcekey="lblCommentsLiteralResource1"></asp:Label>
                                    
                                        <asp:Label ID="lblComments" runat="server" 
                                        meta:resourcekey="lblCommentsResource1"></asp:Label>
                                    </strong>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="a-left">
                                    <strong><asp:Label ID="lblBatchNoLiteral" runat="server" Text="Kit BatchNo :" meta:resourcekey="lblBatchNoLiteralResource1"></asp:Label>
                                        <asp:Label ID="lblBatchNo" runat="server" 
                                        meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <strong><asp:Label ID="lblPatientNoLiteral" runat="server" Text="UHID/Patient Name :" meta:resourcekey="lblPatientNoLiteralResource1"></asp:Label>
                                        <asp:Label ID="lblPatientNo" runat="server" 
                                        meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                    </strong>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="a-left">
                                    <strong>
                                    <asp:Label ID="Label1" runat="server" Text="Date of Surgery :" meta:resourcekey="Label1Resource1"></asp:Label>
                                        <asp:Label ID="Label2" Text=" " runat="server" 
                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <strong>
                                      <asp:Label ID="Label3" runat="server" Text="Packed by:" meta:resourcekey="Label3Resource1"></asp:Label>
                                        <asp:Label ID="lblCreatedBy" runat="server" 
                                        meta:resourcekey="lblCreatedByResource1"></asp:Label>
                                    </strong>
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="a-right" >
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="a-center fontlarger">
                                    <strong> <asp:Label ID="Label4" runat="server" Text="KitCreation Product Details" meta:resourcekey="Label4Resource1"></asp:Label>
                              </strong>
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
                    <td class="v-top">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <%-- <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" GridLines="Both"
                                                CssClass="mytable1" Width="100%" 
                                                PageSize="20" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="Product Name" DataField="ProductName" />
                                                    <asp:BoundField HeaderText="BatchNo"  ItemStyle-Width="100px" DataField="BatchNo" />
                                                    <asp:BoundField HeaderText="QTY"  DataField="Quantity" />
                                                    <asp:BoundField HeaderText="Unit Price" DataField="SellingPrice" />
                                                     <asp:BoundField HeaderText="Total Price" DataField="TSellingPrice" />
                                                    <asp:BoundField HeaderText="Units Used" ItemStyle-Wrap="true" />
                                                     <asp:BoundField HeaderText="Units Unused" ItemStyle-Wrap="true" />
                                                     <asp:BoundField HeaderText="Excess Used" ItemStyle-Wrap="true" />
                                              
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle VerticalAlign="Top" HorizontalAlign="Left" />
                                            </asp:GridView>
                                            --%>
                                <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                                    AutoGenerateColumns="False" CssClass="gridView w-100p" 
                                    PageSize="20" OnRowDataBound="GridViewDetails_RowDataBound"
                                    ShowFooter="True" meta:resourcekey="GridViewDetailsResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SL No." 
                                            meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                                <asp:HiddenField ID="hdnTSellingPrice" runat="server" Value='<%#bind("TSellingPrice")%>' />
                                                <asp:HiddenField ID="hdnSellingPrice" runat="server" Value='<%#bind("SellingPrice")%>' />
                                                <asp:HiddenField ID="hdnProductName" runat="server" Value='<%#bind("ProductName")%>' />
                                                <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%#bind("BatchNo")%>' />
                                                <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%#bind("Quantity")%>' />
                                            </ItemTemplate>
                                            <FooterStyle></FooterStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ProductName" HeaderText="ProductName" 
                                            meta:resourcekey="BoundFieldResource1">
                                            <FooterStyle Font-Bold="True"></FooterStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="BatchNo" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" 
                                                    meta:resourcekey="lblBatchNoResource2"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="Rs_PageTotal" Text=" Total" runat="server" 
                                                    meta:resourcekey="Rs_PageTotalResource1"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="QTY" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblQuantity" Text='<%# Eval("Quantity","{0:N}") %>' runat="server" 
                                                    meta:resourcekey="lblQuantityResource1"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblQty.Text%>
                                            </FooterTemplate>
                                            <FooterStyle Font-Bold="True"></FooterStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit Price" FooterStyle-Font-Bold="true" Visible="false"
                                            meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSellingPrice" Text='<%# Eval("SellingPrice","{0:N}") %>' 
                                                    runat="server" meta:resourcekey="lblSellingPriceResource1"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True"></FooterStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Price" 
                                            meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRECQuantity" Text='<%# Eval("TSellingPrice","{0:N}") %>' 
                                                    runat="server" meta:resourcekey="lblRECQuantityResource1"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTSellingPrice.Text%>
                                            </FooterTemplate>
                                            <FooterStyle Font-Bold="True"></FooterStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Units Used" meta:resourcekey="BoundFieldResource2" >
                                        <ItemStyle Wrap="True" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Units Unused" 
                                            meta:resourcekey="BoundFieldResource3" >
                                        <ItemStyle Wrap="True" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Excess Used" 
                                            meta:resourcekey="BoundFieldResource4" >
                                        <ItemStyle Wrap="True" />
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                                <asp:Label ID="Rs_PageTotal" Text="0" runat="server" Visible="False" 
                                    meta:resourcekey="Rs_PageTotalResource2"></asp:Label>
                                <asp:Label ID="lblQty" Text="0" runat="server" Visible="False" 
                                    meta:resourcekey="lblQtyResource1"></asp:Label>
                                <asp:Label ID="lblTSellingPrice" Text="0" runat="server" Visible="False" 
                                    meta:resourcekey="lblTSellingPriceResource1"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td class="a-left">
                    </td>
                </tr>
            </table>
            <br />
        </div>
        <div>
            <table class="w-95p">
                <tr>
                    <td class="a-center" id="btn">
                        <asp:Button ID="btnPrint" OnClientClick="doPrint();return false;" runat="server"
                            CssClass="btn"
                            Text="Print" meta:resourcekey="btnPrintResource1" />
                        <asp:Button ID="btnBarCode" runat="server" 
                            CssClass="btn" Text="PrintBarCode" OnClick="btnBarCode_Click" 
                            meta:resourcekey="btnBarCodeResource1" />
                    </td>
                </tr>
                <tr>
                    <td class="a-right">
                        <strong><asp:Label ID="lblSign" runat="server" meta:resourcekey="lblSignResource1" 
                        Text="OT Incharge &amp; Anasthetist / Surgeon Signatory"></asp:Label>
                        </strong>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
    
    <script type="text/javascript" language="javascript">
        function doPrint() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            //document.getElementById('btn').style.display = 'none';
            $('#btn').removeClass().addClass('hide');
            WinPrint.document.write(document.getElementById('divProjection').innerHTML);

            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            //document.getElementById('btn').style.display = 'block';
            $('#btn').removeClass().addClass('show');
        }
        
    </script>
    
</body>
</html>
