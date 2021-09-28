<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Cocaineintake.ascx.cs"
    Inherits="CommonControls_Cocaineintake" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trCocaineintake" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblCocaineintake_1108" runat="server" Text="Drug Or Substance abuse" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1108" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1108" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1108" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1108" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlDrugAbuse_1108" onchange="javascript:showOthersBoxHis(this.id);" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <div id="divddlDrugAbuse_1108" runat="server" style="display: none">
                                <asp:TextBox ID="txtDrugs" runat="server"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
