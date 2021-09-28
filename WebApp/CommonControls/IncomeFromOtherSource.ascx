<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IncomeFromOtherSource.ascx.cs"
    Inherits="CommonControls_IncomeFromOtherSource" %>

<script runat="server">
    decimal TotalUnitPrice;
    decimal GetAmount(decimal Price)
    {
        TotalUnitPrice += Price;
        return Price;
    }
    decimal GetTotal()
    {
        return TotalUnitPrice;
    }
</script>

<table>
    <tr>
        <td>
            <asp:GridView ID="grdothersrc" runat="server" AllowPaging="True" CellPadding="1"
                AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                ItemStyle-VerticalAlign="Top" ShowFooter="True" RepeatDirection="Horizontal"
                meta:resourcekey="grdothersrcResource1">
                <HeaderStyle CssClass="dataheader1" />
                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                    PageButtonCount="5" PreviousPageText="" />
                <Columns>
                    <asp:BoundField DataField="SourceName" HeaderText="IncomeSourceName" meta:resourcekey="BoundFieldResource1" />
                    <%--<asp:BoundField DataField="ReceivedCurrencyvalue" HeaderText="Amount" />--%>
                    <asp:BoundField DataField="ReferenceID" NullDisplayText="--" HeaderText="Reference No."
                        meta:resourcekey="BoundFieldResource2" />
                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                        HeaderText="DateTime" meta:resourcekey="BoundFieldResource3" />
                    <asp:BoundField DataField="ModeOFPayment" HeaderText="PaymentType" meta:resourcekey="BoundFieldResource4" />
                    <asp:BoundField DataField="BankName" NullDisplayText="--" HeaderText="BankName" meta:resourcekey="BoundFieldResource5" />
                    <asp:BoundField DataField="ChequeNo" NullDisplayText="--" HeaderText="ChequeNo" meta:resourcekey="BoundFieldResource6" />
                    <asp:BoundField DataField="Description" NullDisplayText="--" HeaderText="Description"
                        meta:resourcekey="BoundFieldResource7" />
                    <asp:BoundField DataField="CurrencyName" FooterText="Total" HeaderText="ReceivedCurreny"
                        meta:resourcekey="BoundFieldResource8" />
                    <asp:TemplateField HeaderText="Received Amount" FooterStyle-Font-Bold="True" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <%# GetAmount(decimal.Parse(Eval("ReceivedCurrencyvalue").ToString()))%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%# GetTotal() %>
                        </FooterTemplate>
                        <FooterStyle Font-Bold="True"></FooterStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
