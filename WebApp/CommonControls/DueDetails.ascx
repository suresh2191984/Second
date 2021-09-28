<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DueDetails.ascx.cs" Inherits="CommonControls_DueDetails" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<script language="javascript" type="text/javascript">

    function OnSucceeded(result) {
        var gvDueDetails = document.getElementById('<%= gvDueDetail.ClientID %>');
        gvDueDetails.load(result);
        gvDueDetails.render();
    } 
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <asp:GridView ID="gvDueDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                OnRowDataBound="gvDueDetail_RowDataBound" 
                meta:resourcekey="gvDueDetailResource1">
                <HeaderStyle CssClass="Duecolor" />
                <PagerStyle CssClass="Duecolor1" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="Bill No" ControlStyle-CssClass="gridControlStyle"
                        FooterStyle-CssClass="gridFooterStyle" HeaderStyle-CssClass="gridHeaderStyle"
                        ItemStyle-CssClass="gridItemStyle" 
                        meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="lblBillNo" runat="server" Text='<%#Bind("BillNumber") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                        <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                        <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                        <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Bill Date"
                        ControlStyle-CssClass="gridControlStyle" FooterStyle-CssClass="gridFooterStyle"
                        HeaderStyle-CssClass="gridHeaderStyle" ItemStyle-CssClass="gridItemStyle" 
                        meta:resourcekey="BoundFieldResource1">
                        <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                        <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                        <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                        <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Bill Date" ShowHeader="false" Visible="false" 
                        meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:Label ID="lblBillDate" runat="server" Text='<%# Bind("CreatedAt") %>' 
                                ></asp:Label><%--meta:resourcekey="lblBillDateResource1"--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="GrossBillValue" ControlStyle-CssClass="gridControlStyle"
                        FooterStyle-CssClass="gridFooterStyle" HeaderStyle-CssClass="gridHeaderStyle"
                        ItemStyle-CssClass="gridItemStyle" HeaderText="Gross Value" 
                        meta:resourcekey="BoundFieldResource2">
<ControlStyle CssClass="gridControlStyle"></ControlStyle>

<FooterStyle CssClass="gridFooterStyle"></FooterStyle>

<HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>

<ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Net Value" ControlStyle-CssClass="gridControlStyle"
                        FooterStyle-CssClass="gridFooterStyle" HeaderStyle-CssClass="gridHeaderStyle"
                        ItemStyle-CssClass="gridItemStyle" 
                        meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblNetValue" runat="server" 
                                Text='<%# Eval("NetValue","{0:F2}") %>' ></asp:Label><%--meta:resourcekey="lblNetValueResource1"--%>
                        </ItemTemplate>
                        <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                        <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                        <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                        <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount Recieved" ControlStyle-CssClass="gridControlStyle"
                        FooterStyle-CssClass="gridFooterStyle" HeaderStyle-CssClass="gridHeaderStyle"
                        ItemStyle-CssClass="gridItemStyle" 
                        meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblAmountRecieved" runat="server" 
                                Text='<%# Eval("AmountReceived","{0:F2}") %>' 
                                ></asp:Label><%--meta:resourcekey="lblAmountRecievedResource1"--%>
                        </ItemTemplate>
                        <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                        <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                        <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                        <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Due" ControlStyle-CssClass="gridControlStyle" FooterStyle-CssClass="gridFooterStyle"
                        HeaderStyle-CssClass="gridHeaderStyle" ItemStyle-CssClass="gridItemStyle" 
                        HeaderText="Current Due" meta:resourcekey="BoundFieldResource3" >
<ControlStyle CssClass="gridControlStyle"></ControlStyle>

<FooterStyle CssClass="gridFooterStyle"></FooterStyle>

<HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>

<ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Cummilative Balance" ControlStyle-CssClass="gridControlStyle"
                        FooterStyle-CssClass="gridFooterStyle" HeaderStyle-CssClass="gridHeaderStyle"
                        ItemStyle-CssClass="gridItemStyle" 
                        meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblDueAmount" runat="server" 
                                Text='<%# Eval("CurrentDue","{0:F2}") %>' 
                                ></asp:Label><%--meta:resourcekey="lblDueAmountResource1"--%>
                        </ItemTemplate>
                        <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                        <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                        <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                        <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
