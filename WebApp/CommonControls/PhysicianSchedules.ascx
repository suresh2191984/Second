<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhysicianSchedules.ascx.cs" Inherits="CommonControls_PhysicianSchedules" %>
<asp:GridView ID="gvToken" runat="server" AutoGenerateColumns="False" 
    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
    CellPadding="3" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" 
    meta:resourcekey="gvTokenResource1">
    <RowStyle ForeColor="#000066" />
    <Columns>
        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
            <ItemTemplate>
                <asp:RadioButton ID="rdoTokenID" runat="server" 
                     /><%--meta:resourcekey="rdoTokenIDResource1"--%>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="TokenNumber" HeaderText="Token" 
            meta:resourcekey="BoundFieldResource1" />
        <asp:BoundField DataField="Name" HeaderText="Patient Name" 
            meta:resourcekey="BoundFieldResource2" />
    </Columns>
    <FooterStyle BackColor="White" ForeColor="#000066" />
    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    <HeaderStyle CssClass="grdcolor" Font-Bold="False"  />
</asp:GridView>
