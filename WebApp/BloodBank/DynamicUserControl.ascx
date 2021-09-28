<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicUserControl.ascx.cs" Inherits="BloodBank_DynamicUserControl" %>
<style type="text/css">
    .style1
    {
        width: 39px;
    }
</style>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table border="0" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr class="defaultfontcolor">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblHeading" runat="server" Font-Bold="True" 
                            meta:resourcekey="lblHeadingResource1"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_32" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoYes_32Resource1" />
                        <asp:RadioButton ID="rdoNo_32" Text="No" runat="server" GroupName="radioExtend" 
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoNo_32Resource1" />
                        <asp:RadioButton ID="rdoUnknown_32" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoUnknown_32Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="divrdoYes_32" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtBox_32" runat="server" Width="150px" 
                                meta:resourcekey="txtBox_32Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    </table>
