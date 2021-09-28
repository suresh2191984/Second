<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargeChkList.ascx.cs" Inherits="CommonControls_DischargeChkList" %>
<style type="text/css">
    .fontSizes
    {
        font-size: 12px;
        font-family: Verdana, Arial;
    }
</style>
<table width="500px" class="fontSizes">
    <tr>
        <td style="width: 175px;" style="font-weight: bold">
            <asp:Label ID="Rs_DateTimeofDischarge" runat="server" 
                Text="Date & Time of Discharge" 
                meta:resourcekey="Rs_DateTimeofDischargeResource1"></asp:Label>
        </td>
        <td style="width: 25px;">&nbsp;:
        </td>
        <td>
            <asp:Label ID="lblDisDT" runat="server" meta:resourcekey="lblDisDTResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold">
            <asp:Label ID="Rs_TypeofDischarge" runat="server" Text="Type of Discharge" 
                meta:resourcekey="Rs_TypeofDischargeResource1"></asp:Label>
        </td>
        <td>&nbsp;:
        </td>
        <td>
            <asp:Label ID="lblTypeofDischarge" runat="server" 
                meta:resourcekey="lblTypeofDischargeResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold">
            <asp:Label ID="Rs_DestinationPostDischarge" runat="server" 
                Text="Destination Post Discharge" 
                meta:resourcekey="Rs_DestinationPostDischargeResource1"></asp:Label>
        </td>
        <td>&nbsp;:
        </td>
        <td>
            <asp:Label ID="lblDestPostDis" runat="server" 
                meta:resourcekey="lblDestPostDisResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold">
            <asp:Label ID="Rs_ConditiononDischarge" runat="server" 
                Text="Condition on Discharge" 
                meta:resourcekey="Rs_ConditiononDischargeResource1"></asp:Label>
        </td>
        <td>&nbsp;:
        </td>
        <td>
            <asp:Label ID="lblConOnDis" runat="server" 
                meta:resourcekey="lblConOnDisResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>&nbsp;
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td colspan="3">
        <asp:GridView ID="grdDisChkList" runat="server" CellPadding="4"
            AutoGenerateColumns="False" DataKeyNames="ChkLstID" Width="500px"
            ForeColor="#333333" GridLines="None" BorderStyle="None" CssClass="fontSizes"
                onrowdatabound="grdDisChkList_RowDataBound" 
                meta:resourcekey="grdDisChkListResource1">
        <HeaderStyle  />
        <Columns>
            <asp:TemplateField ItemStyle-Width="5%" 
                meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:CheckBox ID="ChkSel" style="color: Black; border-color: Black;" 
                        runat="server" ToolTip="Select Row"  /><%--meta:resourcekey="ChkSelResource1"--%>
                </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ChkListID" ItemStyle-Width="5%" Visible="False" 
                meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:Label ID="lblChkLstID" runat="server" Text='<%# Bind("ChkLstID") %>'
                       ></asp:Label> <%--meta:resourcekey="lblChkLstIDResource2"--%> 
                </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="ChkLstDesc" HeaderText="Description" ItemStyle-Width="25%"
                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1">
                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5%" 
                meta:resourcekey="TemplateFieldResource3">
                <ItemTemplate>
                    <asp:Label ID="lblColon" Text='<%# Bind("ChkLstID") %>' runat="server" 
                        ></asp:Label><%--meta:resourcekey="lblChkLstIDResource1"--%>
                </ItemTemplate>

<ItemStyle HorizontalAlign="Left" Width="5%"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-Width="25%"
                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
            </asp:BoundField>
        </Columns>
        </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
</table>