<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Miscellaneous.ascx.cs"
    Inherits="CommonControls_Miscellaneous" %>
<asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="colorforcontent" width="35%" height="23" align="left">
                <div style="display: none" id="ACX2plusM">
                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);">
                        <asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label></span>
                </div>
                <div style="display: block; height: 18px;" id="ACX2minusM">
                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                        style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" />
                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);">
                        <asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></span>
                </div>
            </td>
            <td width="75%" height="23" align="left">
                &nbsp;
            </td>
        </tr>
        <tr class="tablerow" id="ACX2responsesM" style="display: block">
            <td colspan="2">
                <div class="dataheader2">
                    <br />
                    <asp:CheckBox ID="chkAdmit" CssClass="defaultfontcolor" runat="server" Text="Suggest Admission" />
                    <br />
                    <asp:CheckBox ID="chkRefer" CssClass="defaultfontcolor" runat="server" Text="Referral / Medical Letter" />
                    <br />
                    <br clear="all" />
                    &nbsp;<asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"></asp:Label>
                    <asp:DropDownList ID="ddlNos" runat="server">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="6">6</asp:ListItem>
                        <asp:ListItem Value="7">7</asp:ListItem>
                        <asp:ListItem Value="8">8</asp:ListItem>
                        <asp:ListItem Value="9">9</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="0">0</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlDMY" runat="server" meta:resourcekey="ddlDMYResource1">
                        <asp:ListItem Value="Day(s)">Day(s)</asp:ListItem>
                        <asp:ListItem Value="Week(s)">Week(s)</asp:ListItem>
                        <asp:ListItem Value="Month(s)">Month(s)</asp:ListItem>
                        <asp:ListItem Value="Year(s)">Year(s)</asp:ListItem>
                    </asp:DropDownList>
                    <br clear="all" />
                    <br clear="all" />
                </div>
            </td>
        </tr>
    </table>
</asp:Panel>
