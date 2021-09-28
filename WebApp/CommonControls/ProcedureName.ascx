<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProcedureName.ascx.cs"
    Inherits="CommonControls_ProcedureName" %>
<table class="w-100p">
    <tr>
        <td class="w-25p">
            <asp:Label Text="Treatment Procedure:" runat="server" ID="lblProcedurename" meta:resourcekey="lblProcedurenameResource1"></asp:Label>
        </td>
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:DropDownList ID="ddlProcedureName" runat="server" CssClass="ddlTheme12" 
                        AutoPostBack="True" OnSelectedIndexChanged="ddlProcedureName_SelectedIndexChanged"
                        meta:resourcekey="ddlProcedureNameResource1">
                    </asp:DropDownList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
        <td>
            <asp:Label ID="lblDrName" Visible="False" runat="server" Text="Dr Name" meta:resourcekey="lblDrNameResource1"></asp:Label>
        </td>
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:DropDownList ID="ddlPhysicianByProcedure" runat="server" CssClass="ddlTheme12"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlPhysicianByProcedure_SelectedIndexChanged"
                        meta:resourcekey="ddlPhysicianByProcedureResource1">
                    </asp:DropDownList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
