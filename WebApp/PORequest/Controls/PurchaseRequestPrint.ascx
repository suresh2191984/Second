<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PurchaseRequestPrint.ascx.cs"
    Inherits="PORequest_Controls_PurchaseRequestPrint" %>
<table class="w-100p">
    <tr>
        <td class="a-left">
            <strong> <%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_01%>
                <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label></strong>
        </td>
        <td class="a-right">
            <strong> <%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_02%>
                <asp:Label ID="lblPORNo" runat="server" 
                meta:resourcekey="lblPORNoResource1"></asp:Label>
            </strong>
        </td>
    </tr>
    <tr>
        <td class="a-left">
            <strong><%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_03%>
                <asp:Label ID="lblPORequestedBy" runat="server" 
                meta:resourcekey="lblPORequestedByResource1"></asp:Label></strong>
        </td>
        <td class="a-right">
            <strong><%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_04%>
                <asp:Label ID="lblStatus" runat="server" 
                meta:resourcekey="lblStatusResource1"></asp:Label>
            </strong>
        </td>
    </tr>
    <tr>
        <td class="a-left">
            <strong><%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_05%>
                <asp:Label ID="lblPORToLocation" runat="server" 
                meta:resourcekey="lblPORToLocationResource1"></asp:Label></strong>
        </td>
        <td class="a-right">
        </td>
    </tr>
    <tr>
        <td class="a-left">
            <strong><%=Resources.PORequest_ClientDisplay.PORequest_PurchaseRequestPrint_ascx_06%>
                <asp:Label ID="lblPORFromLocation" runat="server" 
                meta:resourcekey="lblPORFromLocationResource1"></asp:Label></strong>
        </td>
        <td class="a-right">
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table class="w-100p">
                <tr>
                    <td>
                        <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                            AutoGenerateColumns="False" CssClass="gridView w-100p"
                            meta:resourcekey="GridViewDetailsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." 
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Description" HeaderText="Product Name" 
                                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                <asp:BoundField DataField="Unit" HeaderText="SellingUnit" 
                                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                <asp:BoundField DataField="ProductID" HeaderText="ProductID" 
                                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
   <%-- <tr>
        <td align="center" colspan="2">
            <asp:Button ID="btnsearch" runat="server" CssClass="btn" Text="Print" OnClientClick="return doPrint();" />
        </td>
    </tr>--%>
</table>
