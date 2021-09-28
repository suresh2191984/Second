<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioPattern5.ascx.cs" Inherits="Investigation_BioPattern5" %>
<style type="text/css">
    .style1
    {
        height: 26px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<asp:Panel runat="server" ID="pnGTT" Visible="True" meta:resourcekey="pnGTTResource1">
    <table class="w-50p">
        <tr>
            <td class="a-left w-40p style1">
                <label class="defaultfontcolor">
                    <asp:Label ID="Rs_NoOftests" Text="No. Of tests" runat="server" meta:resourcekey="Rs_NoOftestsResource1"></asp:Label></label>
            </td>
            <td class="style1">
                <asp:TextBox ID="t13015" runat="server" CssClass="textbox_hemat small" meta:resourcekey="t13015Resource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="a-left h-26 w-40p">
                <label class="defaultfontcolor">
                    <asp:Label ID="Rs_StartTime" Text="Start Time" runat="server" meta:resourcekey="Rs_StartTimeResource1"></asp:Label></label>
            </td>
            <td>
                <asp:DropDownList ID="ddlStartTime" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlStartTimeResource1">
                    <%--<asp:ListItem meta:resourcekey="ListItemResource1">1</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource2">2</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource3">3</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource4">4</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource5">5</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource6">6</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource7">7</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource8">8</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource9">9</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource10">10</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource11">11</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource12">12</asp:ListItem>--%>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlampm" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlampmResource1">
                    <%--<asp:ListItem meta:resourcekey="ListItemResource13">am</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource14">pm</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="a-left h-27 w-40p">
                <label class="defaultfontcolor">
                    <asp:Label ID="Rs_TimeInterval" Text="Time Interval(min)" runat="server" meta:resourcekey="Rs_TimeIntervalResource1"></asp:Label></label>
            </td>
            <td>
                <asp:DropDownList ID="ddlTimeInterval" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlTimeIntervalResource1">
                    <%--<asp:ListItem meta:resourcekey="ListItemResource15">10</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource16">20</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource17">30</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource18">40</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource19">50</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="a-left h-27 w-40p">
                <label class="defaultfontcolor">
                    <asp:Label ID="Rs_gramsofSugar" Text="grams of Sugar" runat="server" meta:resourcekey="Rs_gramsofSugarResource1"></asp:Label></label>
            </td>
            <td>
                <asp:TextBox ID="txtSugar" runat="server" CssClass="textbox_hemat small" meta:resourcekey="txtSugarResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="a-center" colspan="2">
                <asp:Button ID="btnGenerate" runat="server" OnClick="btnGenerate_Click" CssClass="btn"
                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Text="Generate"
                    meta:resourcekey="btnGenerateResource1" />
            </td>
        </tr>
    </table>
</asp:Panel>
<table>
    <tr>
        <td colspan="2" style="padding-left: 20px">
            <asp:Panel ID="pn3016" runat="server" meta:resourcekey="pn3016Resource1">
            </asp:Panel>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
    </tr>
</table>
