<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvKitCancel.aspx.cs" Inherits="InventoryKit_InvKitCancel" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print KitCreation Detail View</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
                    <div class="contentdata" id="divProjection">
                        <div>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <%--<uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class ="a-center">
                                        <h3>
                                            <asp:Label ID="lblOrgName" runat="server" 
                                                meta:resourcekey="lblOrgNameResource1"></asp:Label></h3>
                                    </td>
                                </tr>
                                <tr id="trProductDetail" runat="server">
                                    <td>
                                        <table class="w-95p" cellpadding="4" cellspacing="2">
                                            <tr>
                                                <td class="a-left">
                                                    <b><asp:Label ID="lblDate1" runat="server" Text="Date :" 
                                                        meta:resourcekey="lblDate1Resource1"></asp:Label>
                                                    
                                                        <asp:Label ID="lblDate" runat="server" Font-Bold="True" 
                                                        meta:resourcekey="lblDateResource1"></asp:Label></b>
                                                </td>
                                                <td class="a-right">
                                                    <strong><asp:Label ID="lblKitProductName" runat="server" 
                                                        Text="Kit ProductName:" meta:resourcekey="lblKitProductNameResource1"></asp:Label>
                                                    
                                                        <asp:Label ID="lblKitID" Font-Bold="True" runat="server" 
                                                        meta:resourcekey="lblKitIDResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <strong><asp:Label ID="lblComment" runat="server" Text="Comments:" 
                                                        meta:resourcekey="lblCommentResource1"></asp:Label>
                                                    
                                                        <asp:Label ID="lblComments" runat="server" 
                                                        meta:resourcekey="lblCommentsResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="a-right">
                                                    <strong><asp:Label ID="lblKitBatchNo" runat="server" Text="Kit BatchNo :" 
                                                        meta:resourcekey="lblKitBatchNoResource1"></asp:Label>
                                                    
                                                        <asp:Label ID="lblBatchNo" runat="server" 
                                                        meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <strong><asp:Label ID="lblCanceled" runat="server" Text="Canceled by:" 
                                                        meta:resourcekey="lblCanceledResource1"></asp:Label>
                                                    
                                                        <asp:Label ID="lblCanceledBy" runat="server" 
                                                        meta:resourcekey="lblCanceledByResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="a-right">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class ="a-center fontlarger">
                                        <strong><asp:Label ID="Label3" runat="server" Text="Comments:" 
                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                            <asp:Label ID="lblkitcancelProductDetails" runat="server" 
                                            Text="Kit Cancel Product Details" 
                                            meta:resourcekey="lblkitcancelProductDetailsResource1" ></asp:Label>
                                             </strong>
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
                                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False"
                                                    CssClass="gridView w-100p" PageSize="20" 
                                            OnRowDataBound="gvResult_RowDataBound" ShowFooter="True" 
                                            meta:resourcekey="gvResultResource1" >
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No" ItemStyle-Width="10px" 
                                                            meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                           <FooterStyle></FooterStyle>

                                                            <ItemStyle Width="10px"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderText="Product Name" DataField="ProductName" 
                                                            meta:resourcekey="BoundFieldResource1" >
                                                          <FooterStyle  Font-Bold="True"></FooterStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="BatchNo" FooterStyle-Font-Bold="true" 
                                                            ItemStyle-Width="60px" meta:resourcekey="TemplateFieldResource2" >
                                                        <ItemTemplate >
                                                        
                                                        <asp:Label ID="lblBatchNo" Text='<%# Eval("BatchNo") %>' runat="server" 
                                                                ></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate >
                                                        <asp:Label ID="Rs_PageTotal" Text=" Total" runat="server" 
                                                                meta:resourcekey="Rs_PageTotalResource1" ></asp:Label>
                                                       </FooterTemplate>

                                                        <FooterStyle Font-Bold="True"></FooterStyle>

                                                        <ItemStyle Width="60px"></ItemStyle>
                                                        </asp:TemplateField>
                                                        
                                                     <asp:TemplateField HeaderText="QTY" FooterStyle-Font-Bold="true" 
                                                            meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQuantity" Text='<%# Eval("Quantity") %>' runat="server" 
                                                             ></asp:Label>    
                                                    </ItemTemplate>
                                                        <FooterTemplate>
                                                        <%# lblQty.Text%>
                                                    </FooterTemplate>
                                                  
                                                   <FooterStyle Font-Bold="True"></FooterStyle>
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Unit Price" FooterStyle-Font-Bold="true" 
                                                            Visible="false" meta:resourcekey="TemplateFieldResource4"  >               
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSellingPrice" Text='<%# Eval("SellingPrice") %>' 
                                                            runat="server"   ></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterStyle  Font-Bold="True"></FooterStyle>
                                                </asp:TemplateField>
                                                   <asp:TemplateField HeaderText="Total Price" FooterStyle-Font-Bold="true" 
                                                            meta:resourcekey="TemplateFieldResource5" >
                                                   
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRECQuantity" Text='<%# Eval("TSellingPrice") %>' 
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                   <FooterTemplate>
                                                        <%# lblTSellingPrice.Text%>
                                                    </FooterTemplate>
                                                    <FooterStyle  Font-Bold="True"></FooterStyle>
                                                 
                                                </asp:TemplateField>
                                                        
                                                        
                                                       <%-- <asp:BoundField HeaderText="BatchNo" ItemStyle-Width="100px" DataField="BatchNo" />
                                                        <asp:BoundField HeaderText="QTY" DataField="Quantity" />
                                                        <asp:BoundField HeaderText="Unit Price" DataField="SellingPrice" />--%>
                                                    </Columns>
                                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="gridHeader" />
                                                    <RowStyle VerticalAlign="Top" HorizontalAlign="Left" />
                                                </asp:GridView>
                                               <asp:Label ID="Rs_PageTotal" Text="0" runat="server" Visible="False" 
                                            meta:resourcekey="Rs_PageTotalResource2" ></asp:Label>
                                               <asp:Label ID="lblQty" Text="0" runat="server" Visible="False" 
                                            meta:resourcekey="lblQtyResource1" ></asp:Label>
                                               <asp:Label ID="lblTSellingPrice" Text="0" runat="server" Visible="False" 
                                            meta:resourcekey="lblTSellingPriceResource1" ></asp:Label>
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
                                    <td class ="a-center" id="btn">
                                        <asp:Button ID="btnPrint" OnClientClick="doPrint();return false;" runat="server"
                                            CssClass="btn"
                                            Text="Print" meta:resourcekey="btnPrintResource1" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnCancel" runat="server"
                                            CssClass="cancel-btn" Text="Cancel Kit" Width="66px" OnClientClick="javascript:return ConfirmCancel();"
                                            OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnHome" runat="server"
                                            CssClass="btn" Text="Home" OnClick="btnHome_Click" 
                                            meta:resourcekey="btnHomeResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right">
                                        <strong></strong>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />       
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
    
    <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("InventoryKit_Error") != null ? SListForAppMsg.Get("InventoryKit_Error") : "Alert";
        var InformationMsg = SListForAppMsg.Get("InventoryKit_Information") != null ? SListForAppMsg.Get("InventoryKit_Information") : "Information";
        var okMsg = SListForAppMsg.Get("InventoryKit_Ok") != null ? SListForAppMsg.Get("InventoryKit_Ok") : "Ok";
        var CancelMsg = SListForAppMsg.Get("InventoryKit_Cancel") != null ? SListForAppMsg.Get("InventoryKit_Cancel") : "Cancel";
   </script>
   
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
        function ConfirmCancel() {
            var userMsg = SListForAppMsg.Get("InventoryKit_InvKitCancel_aspx_01") == null ? "Are you sure you wish to cancel this Kit?" : SListForAppMsg.Get("InventoryKit_InvKitCancel_aspx_01");
            var con = ConfirmWindow(userMsg, InformationMsg, OkMsg, CancelMsg)
            if (con == true) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</body>
</html>
