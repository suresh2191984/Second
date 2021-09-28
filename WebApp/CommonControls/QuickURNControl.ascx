<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuickURNControl.ascx.cs" Inherits="CommonControls_QuickURNControl" %>

<table width="100%" cellpadding="2" cellspacing="0">
    <tr>
        <td align="left">
            <asp:Label ID="litTitle" Text="Unique Reference Number" Font-Bold="True" runat="server"
                meta:resourcekey="litTitleResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="1" cellspacing="0" class="tabledata">
                <tr>
                    <td style="width: 10%" align="right">
                        <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" 
                            meta:resourcekey="Rs_URNTypeResource1" CssClass="biltextb"/>
                    </td>
                    <td align="left" style="width: 15%">
                        <asp:DropDownList ID="ddlUrnType" runat="server" TabIndex="26" onblur="CheckExistingURN();"
                            onChange="javascript:return CheckMRD();" 
                            meta:resourcekey="ddlUrnTypeResource1" CssClass="bilddltb">
                        </asp:DropDownList>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td style="width: 10%" align="right">
                        <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of" meta:resourcekey="Rs_URNOfResource1" CssClass="biltextb"></asp:Label>
                    </td>
                    <td align="left" style="width: 15%">
                        <asp:DropDownList ID="ddlUrnoOf" runat="server" TabIndex="27" meta:resourcekey="ddlUrnoOfResource1" CssClass="bilddltb">
                        </asp:DropDownList>
                    </td>                
                    <td style="width: 10%" align="right">
                        <asp:Label ID="Rs_URN" Text="URN" runat="server" 
                            meta:resourcekey="Rs_URNResource1" CssClass="biltextb"/>
                    </td>
                    <td align="left" style="width: 40%">
                        <input type="hidden" id="hdnUrn" runat="server" value="0" />
                        <asp:TextBox ID="txtURNo" onblur="CheckExistingURN();ConverttoUpperCase(this.id)"
                            runat="server" MaxLength="50" TabIndex="28" 
                            meta:resourcekey="txtURNoResource1" CssClass="biltextb"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td style="width: 15%" align="right">
                    </td>
                    <td style="width: 25%">
                    </td>
                </tr>                
            </table>
        </td>
    </tr>
</table>

<script language="javascript" type="text/javascript">
    function CheckMRD() {

        var obj = document.getElementById('<%= ddlUrnType.ClientID %>');

        if (obj.options[obj.selectedIndex].value == 6) {
            document.getElementById('<%= txtURNo.ClientID %>').disabled = true;
            document.getElementById('<%= ddlUrnoOf.ClientID %>').disabled = true;

        }
        else {
            document.getElementById('<%= txtURNo.ClientID %>').disabled = false;
            document.getElementById('<%= ddlUrnoOf.ClientID %>').disabled = false;
        }
        return false;
    }
</script>