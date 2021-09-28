<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductReminderDisplay.ascx.cs"
    Inherits="CommonControls_ProductReminderDisplay" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Label ID="lblRemainderDetail" runat="server" Text="Product Maintenance Reminder Display"
                        CssClass="tdHeaderBGColor" meta:resourcekey="lblRemainderDetailResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="defaultfontcolor w-100p">
                    <asp:GridView ID="gvRemainder" runat="server" CssClass="gridView w-96p m-auto" AutoGenerateColumns="False"
                        OnRowCommand="gvRemainder_RowCommand" 
                        OnRowDataBound="gvRemainder_RowDataBound" 
                        meta:resourcekey="gvRemainderResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemainderID" runat="server" Text='<%# Bind("ProductID") %>' />
                                        <%--meta:resourcekey="lblRemainderIDResource1"--%>
                                </ItemTemplate>
                                <ControlStyle></ControlStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="NextMaintenanceDate" DataFormatString="{0:dd-MMM-yyyy}"
                                HeaderText="Maintenance date" HeaderStyle-HorizontalAlign="Center" 
                                ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource1">
                                <HeaderStyle CssClass="w-10p" />
                                <ItemStyle CssClass="w-10p" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                meta:resourcekey="BoundFieldResource2">
                                <HeaderStyle CssClass="w-15p" />
                                <ItemStyle CssClass="w-15p" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Notes" HeaderText="Notes" 
                                meta:resourcekey="BoundFieldResource3">
                                <HeaderStyle CssClass="w-20p" />
                                <ItemStyle CssClass="w-20p" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Frequency" HeaderText="Maintenance Frequency" 
                                meta:resourcekey="BoundFieldResource4">
                                <HeaderStyle CssClass="w-10p" />
                                <ItemStyle CssClass="w-10p" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AmcProvider" HeaderText="Servicer Details" 
                                meta:resourcekey="BoundFieldResource5">
                                <HeaderStyle CssClass="w-35p" />
                                <ItemStyle CssClass="w-35p" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <input type="hidden" id="hdnSelectedRowIndex" runat="server" value="-1" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>