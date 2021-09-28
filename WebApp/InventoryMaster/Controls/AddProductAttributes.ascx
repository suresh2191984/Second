<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddProductAttributes.ascx.cs"
    Inherits="InventoryMaster_Controls_AddTaxDetails" %>
    


<table id="tbltaxDetails" runat="server" class="w-100p">
    <tr>
        <td class="a-left w-13p">
            <asp:Label ID="lblPurchasePrice" runat="server" Text="Purchase Price" meta:resourcekey="lblPurchasePriceResource1"></asp:Label>
        </td>
        <td  class="a-left w-20p">
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAddPurchasePrice" runat="server" CssClass="medium" onkeydown="return validatenumber(event);" meta:resourcekey="txtAddPurchasePriceResource1"></asp:TextBox>
        </td>
        <td class="a-left w-13p">
            <asp:Label ID="lblSupplierName" runat="server" Text="Prefered Supplier" meta:resourcekey="lblSupplierNameResource1"></asp:Label>
        </td>
        <td  class="a-left w-20p">
            <asp:DropDownList ID="ddlSupplierName" runat="server" CssClass="medium" meta:resourcekey="ddlSupplierNameResource1">
            </asp:DropDownList>
        </td>
       <%-- <td class="a-left">
            <asp:Label ID="lblTax" runat="server" Text="Tax" meta:resourcekey="lblTaxResource1"></asp:Label>
        </td>
        <td class="a-left">
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtTax" runat="server" CssClass="small meta:resourcekey="txtTaxResource1"></asp:TextBox>
        </td>--%>
        <td class="a-left w-13p">
            <asp:Label ID="lblDiscount" runat="server" Text="Discount" meta:resourcekey="lblDiscountResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDiscount" runat="server"  MaxLength="50" onkeydown="return validatenumber(event);"  CssClass="medium" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
        </td>
    </tr>
        <tr>
        
         <%--<td class="a-left">
            <asp:Label ID="lblUomStockInHand" runat="server" Text="Uom Stock InHand" meta:resourcekey="lblUomStockInHandResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtUomStockInhand" runat="server" CssClass="medium" meta:resourcekey="txtUomStockInhandResource1"></asp:TextBox>
        </td>--%>
        <td class="a-left">
            <asp:Label ID="lblInverseQuantity" runat="server" Text="Inverse Quantity" meta:resourcekey="lblInverseQuantityResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtInverseQuantity" runat="server" CssClass="medium" onkeydown="return validatenumber(event);" meta:resourcekey="txtInverseQuantityResource1"></asp:TextBox>
        </td>
        
    </tr>
</table>
