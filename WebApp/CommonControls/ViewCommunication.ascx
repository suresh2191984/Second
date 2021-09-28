<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewCommunication.ascx.cs"
    Inherits="CommonControls_ViewCommunication" %>
<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>

        <script language="javascript" type="text/javascript">
            var oldgridcolor;
            function SetMouseOver(element) {
                oldgridcolor = element.style.backgroundColor;
                element.style.backgroundColor = '#F0F0F0';
            }
            function SetMouseOut(element) {
                element.style.backgroundColor = oldgridcolor;
                element.style.textDecoration = 'none';

            }
        </script>

        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
                <td>
                    <div id="ViewCommunication" runat="server">
                        <asp:GridView ID="grdViewCommunication" runat="server" AutoGenerateColumns="False"
                            BackColor="LightGray" BorderColor="#FFFFFF" BorderWidth="0px" Font-Names="verdana"
                            Font-Size="8pt" GridLines="None" PageSize="20" PagerStyle-ForeColor="black" ClientIDMode="Static"
                            Height="12%" Style="margin-left: 0px" Width="100%" EmptyDataText="No Matching Records found"
                            DataKeyNames="CommID, CommType, CommCode, ACKRequired" OnRowCommand="grdViewCommunication_RowCommand"
                            OnRowDataBound="grdViewCommunication_RowDataBound">
                            <HeaderStyle BackColor="#2c88b1" />
                            <RowStyle ForeColor="#000066" BorderColor="#88C0DE" BorderWidth="1px" Height="28px"
                                VerticalAlign="Middle" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="CommID" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommID" runat="server" Text='<%# Bind("CommID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="RoleID" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleID" runat="server" Text='<%# Bind("RoleID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="LoginID" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLoginID" runat="server" Text='<%# Bind("LoginID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="CommType" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommType" runat="server" Text='<%# Bind("CommType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="CommCode" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommCode" runat="server" Text='<%# Bind("CommCode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="ACKRequired" ItemStyle-VerticalAlign="Middle"
                                    meta:resourcekey="TemplateFieldResource1" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblACKRequired" runat="server" Text='<%# Bind("ACKRequired") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="From" HeaderStyle-Font-Size="8pt"
                                    HeaderStyle-HorizontalAlign="Left" HeaderStyle-BackColor="#2c88b1" HeaderStyle-ForeColor="White"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCreatedby" runat="server" Text='<%# Bind("BroadcastedBy") %>' ForeColor="Black"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="To" HeaderStyle-Font-Size="8pt"
                                    HeaderStyle-HorizontalAlign="Left" HeaderStyle-BackColor="#2c88b1" HeaderStyle-ForeColor="White"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblToName" runat="server" Text='<%# Bind("ToName") %>' ForeColor="Black"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText=" " HeaderStyle-Font-Size="8pt"
                                    HeaderStyle-HorizontalAlign="Left" HeaderStyle-BackColor="#2c88b1" HeaderStyle-ForeColor="White"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTypeIndicator" runat="server" Text=" " ForeColor="Black"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    HeaderStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="White" HeaderText="Message(s)"
                                    HeaderStyle-Font-Size="8pt" Visible="True" HeaderStyle-BackColor="#2c88b1">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkCommContent" runat="server" Text='<%# Bind("CommContent") %>'
                                            CommandName="View" ForeColor="Black" OnClick="lnkCommContent_Click" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ID" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("CommCategoryID") %>' ForeColor="Black"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" VerticalAlign="Middle"
                                Width="14px" ForeColor="Black" />
                            <HeaderStyle CssClass="dataheader1" Width="14px" BackColor="#D7D7D7" Height="28px"
                                ForeColor="Black" HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
