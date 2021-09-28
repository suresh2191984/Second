<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Drugs.ascx.cs" Inherits="CommonControls_Drugs" %>
<%--
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>


<script language="javascript" type="text/javascript">
     
</script>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trDrugs" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td>
                        <asp:Label ID="lblDrugs_1063" runat="server" Text="Drug History"></asp:Label>
                    </td>
                    <td align="right" colspan="2">
                        <asp:RadioButton ID="rdoYes_1063" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1063" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1063" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
                <tr align="left">
                    <td align="left">
                        <div id="divrdoYes_1063" runat="server" style="display: none">
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlDrugs_1063" onchange="javascript:showOthersBoxHis(this.id);" runat="server" ></asp:DropDownList>
                                    </td>
                                    <td>
                                        <div id="divddlDrugs_1063" runat="server" style="display: none">
                                          <asp:TextBox ID="txtDrugs" runat="server"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidList" runat="server" />
