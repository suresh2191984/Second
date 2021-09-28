<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvancedSearch.ascx.cs"
    Inherits="CommonControls_AdvancedSearch" %>

<table class="w-100p">
    <tr>
        <td>
            <asp:Label ID="lblHeader" Font-Bold="True" runat="server" Text="The data you are looking for,is not available in current queue. Following are the current status of the investigations"
                meta:resourcekey="lblHeaderResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="a-center">
            <asp:GridView ID="grdResult" class="w-100p" Visible="true" runat="server" AllowPaging="false"
                AutoGenerateColumns="False" PageSize="15" PagerStyle-ForeColor="black" meta:resourcekey="grdResultResource1">
                <Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="InvestigationName" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="lblNameResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OrderedDateAndTime" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblCreated" runat="server" Text='<%# Bind("CreatedAt") %>' meta:resourcekey="lblCreatedResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CurrentStatus" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' meta:resourcekey="lblStatusResource2"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type" Visible="false" meta:resourcekey="TemplateFieldResource7">
                        <ItemTemplate>
                            <asp:Label ID="lblType" runat="server" Text='<%# Bind("Type") %>' Visible="False"
                                meta:resourcekey="lblTypeResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type" Visible="false" meta:resourcekey="TemplateFieldResource8">
                        <ItemTemplate>
                            <asp:Label ID="lblUID" runat="server" Text='<%# Bind("UID") %>' Visible="False" meta:resourcekey="lblUIDResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="Location--%>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>
