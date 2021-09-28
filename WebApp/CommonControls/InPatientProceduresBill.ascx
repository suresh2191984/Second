<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InPatientProceduresBill.ascx.cs"
    Inherits="CommonControls_InPatientProceduresBill" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="Center">
            &nbsp;
        </td>
        <td align="Center">
            <asp:Label ID="Rs_TreatmentProcedure" runat="server" Text="Treatment Procedure" meta:resourcekey="Rs_TreatmentProcedureResource1"></asp:Label>
        </td>
        <td align="Center">
            &nbsp;&nbsp;
        </td>
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlProcedureName" EventName="SelectedIndexChanged" />
                </Triggers>
                <ContentTemplate>
                    <asp:DropDownList ID="ddlProcedureName" runat="server" TabIndex="5" AutoPostBack="True"
                        OnSelectedIndexChanged="ddlProcedureName_SelectedIndexChanged" meta:resourcekey="ddlProcedureNameResource1">
                    </asp:DropDownList>
                    </tr>
                    <tr>
                        <td align="center">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td align="center" colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td colspan="3">
                            <asp:GridView ID="gvProcedureDetails" runat="server" Width="100%" CellPadding="4"
                                CssClass="mytable1" AutoGenerateColumns="False" DataKeyNames="ID" ForeColor="#333333"
                                HorizontalAlign="Left" OnRowDataBound="gvProcedureDetails_RowDataBound" meta:resourcekey="gvProcedureDetailsResource1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkIDSelected" runat="server" />
                                            <%--meta:resourcekey="chkIDSelectedResource1"--%>
                                            <asp:Label ID="lblID" runat="server" Visible="False" Text='<%# Eval("ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Descrip" HeaderText="Procedure Name" meta:resourcekey="BoundFieldResource1" />
                                    <asp:TemplateField HeaderText="Unit Price" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAmount" Text='<%# Eval("Amount") %>' runat="server" Width="74px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtQuantity" Text="1" runat="server" Width="74px"> <%--meta:resourcekey="txtQuantityResource1"--%></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnFromDate" Value='<%= DateTime.Now %>' runat="server" />
