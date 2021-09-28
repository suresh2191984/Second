<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlListDetails.ascx.cs"
    Inherits="CommonControls_ControlListDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<asp:GridView ID="gdvCustomerControls" runat="server" AutoGenerateColumns="False"
    CssClass="" EmptyDataText="No ConfigKey Found!" GridLines="Both" OnRowDataBound="gdvCustomerControls_RowDataBound"
    ShowHeader="false" Width="100%">
    <Columns>
        <asp:TemplateField Visible="false" HeaderText="S.No.">
            <ItemTemplate>
                <%#Container.DataItemIndex+1 %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField Visible="true" HeaderText="DisplayText">
            <ItemTemplate>
                <asp:HiddenField ID="hdnControlMappingID" runat="server" Value='<%# Eval("ControlMappingID") %>' />
                <asp:HiddenField ID="hdnControlTypeID" runat="server" Value='<%# Eval("ControlTypeID") %>' />
                <asp:HiddenField ID="hdnControlCode" runat="server" Value='<%# Eval("ControlCode") %>' />
                <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("ID") %>' />
                <asp:Label ID="LblDisplayTextGrid" runat="server" Text='<%# Eval("DisplayText") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:DropDownList ID="ddlControlValue" runat="server" Visible="false" Width="180px">
                </asp:DropDownList>
                <asp:TextBox ID="txtControlValue" runat="server" Visible="false" Width="180px"></asp:TextBox>
                <asp:TextBox ID="txtControldade" runat="server" Visible="false" Width="180px"></asp:TextBox>
                <ajc:CalendarExtender TargetControlID="txtControldade" PopupButtonID="txtControldade"
                    ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" Enabled="True" />
                <asp:RadioButtonList ID="rdoControlValue" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    Visible="false" Width="180px" />
                <asp:CheckBoxList ID="chBLControlValue" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    Visible="false" />
                   <asp:CheckBox ID="chkConfigValue" Text="Yes" Visible="false" runat="server"    />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
