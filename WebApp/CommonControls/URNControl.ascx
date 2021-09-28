<%@ Control Language="C#" AutoEventWireup="true" CodeFile="URNControl.ascx.cs" Inherits="CommonControls_URNControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p">
    <tr>
        <td class="a-left">
            <asp:Label ID="litTitle" Text="Unique Reference Number" Font-Bold="True" runat="server"
                meta:resourcekey="litTitleResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <table class="tabledata w-100p">
                <tr>
                    <td style="width: 169px;">
                        <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" meta:resourcekey="Rs_URNTypeResource1" />
                    </td>
                    <td style="width: 300px;">
                        <asp:DropDownList ID="ddlUrnType" CssClass="ddlsmall" runat="server" TabIndex="26"
                            onblur="CheckExistingURN();" onChange="javascript:return CheckMRD();" meta:resourcekey="ddlUrnTypeResource1">
                        </asp:DropDownList>
                        <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                    </td>
                    <td style="width: 150px;">
                        <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of" meta:resourcekey="Rs_URNOfResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlUrnoOf" CssClass="ddlsmall" runat="server" TabIndex="27"
                            meta:resourcekey="ddlUrnoOfResource1">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_URN" Text="URN" runat="server" meta:resourcekey="Rs_URNResource1" />
                    </td>
                    <td>
                        <input type="hidden" id="hdnUrn" runat="server" value="0" />
                        <asp:TextBox ID="txtURNo" CssClass="Txtboxsmall" onblur="CheckExistingURN();ConverttoUpperCase(this.id)"
                            runat="server" MaxLength="50" TabIndex="28" meta:resourcekey="txtURNoResource1"></asp:TextBox>
                      <%--  <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                    </td>
                    <td>
                        <asp:Label ID="lblValiddate" Text="Exp Date" runat="server" 
                            meta:resourcekey="lblValiddateResource1" />
                    </td>
                    <td>
                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" ErrorTooltipEnabled="True"
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtValidate" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True" />
                           
                        <asp:TextBox ID="txtValidate" CssClass="Txtboxsmall" runat="server" 
                            TabIndex="29" meta:resourcekey="txtValidateResource1" ></asp:TextBox>
                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                            TargetControlID="txtValidate" Enabled="True" />
                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False"
                            ImageUrl="~/images/Calendar_scheduleHS.png" 
                            onblur="javascript:return CheckValidate();" 
                            meta:resourcekey="ImgBntCalcResource1"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
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

    function CheckValidate() {
        var ValExpValue = document.getElementById('<%= txtValidate.ClientID %>').value;
        if (ValExpValue != "") {
            ExcedDate('<%= txtValidate.ClientID %>', '', 0, 1);
        }
        return false;
    }
</script>

