<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AlcoholConsumption.ascx.cs"
    Inherits="CommonControls_AlcoholConsumption" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor">
        <td style="width: 200px">
            <asp:Label ID="lblAC_369" runat="server" Text="Alcohol Consumption" 
                Font-Bold="True" meta:resourcekey="lblAC_369Resource1"></asp:Label>
        </td>
        <td align="left" colspan="1">
            <asp:RadioButton ID="rdoYes_369" Text="Yes" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" 
                meta:resourcekey="rdoYes_369Resource1" />
            <asp:RadioButton ID="rdoNo_369" Text="No" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" 
                meta:resourcekey="rdoNo_369Resource1" />
            <asp:RadioButton ID="rdoUnknown_369" Text="Unknown" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" 
                meta:resourcekey="rdoUnknown_369Resource1" />
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td colspan="2">
            <div id="divrdoYes_369" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%" >
                    <tr>
                        <td>
                            <table style="width: 75%;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTypeAC_4" runat="server" CssClass="defaultfontcolor" Text="Type"
                                            meta:resourcekey="lblTypeAC_4Resource1"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="ddlTypesAC_12" onchange="javascript:showOthersBoxHis(this.id);"
                                            runat="server" meta:resourcekey="ddlTypesAC_12Resource1">
                                            <asp:ListItem Value="0" Text ="---Select---" 
                                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR16" Visible="true" runat="server" />
                                        </td>--%>
                                    <td>
                                        <div id="divddlTypesAC_12" runat="server" style="display: none">
                                            <asp:TextBox ID="txtOthersTypeAC_17" runat="server" meta:resourcekey="txtOthersTypeAC_17Resource1"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblQtyAC_6" runat="server" CssClass="defaultfontcolor" Text="Qty"
                                            meta:resourcekey="lblQtyAC_6Resource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ID="txtQtyAC" Width="35px" runat="server" onKeyDown="return  isNumeric(event,this.id)"
                                            meta:resourcekey="txtQtyACResource1"></asp:TextBox>
                                        <asp:Label ID="lblMlLtr" runat="server" CssClass="defaultfontcolor" Text="ml/day"
                                            meta:resourcekey="lblMlLtrResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDurationAC_5" runat="server" CssClass="defaultfontcolor" Text="Duration"
                                            meta:resourcekey="lblDurationAC_5Resource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtDurationAC" Width="35px" runat="server" onKeyDown="return  isNumeric(event,this.id)"
                                            meta:resourcekey="txtDurationACResource1"></asp:TextBox>
                                        <asp:DropDownList ID="ddlDurationAC" runat="server" meta:resourcekey="ddlDurationACResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <%-- <td style="display:none">
                                            <uc8:EMR ID="EMR17" Visible="false" runat="server" />
                                        </td>--%>
                                <tr>
                                    <td colspan="3">
                                        <asp:CheckBox ID="chkQuitAlc_4" runat="server" Text="Quit" 
                                            onclick="javascript:showQuitDet(this.id);" 
                                            meta:resourcekey="chkQuitAlc_4Resource1" />
                                    </td>
                                    <td id="tdchkQuitAlc_4" style="display: none;" colspan="8" runat="server">
                                        <asp:Label ID="Label10" CssClass="defaultfontcolor" runat="server" Text="Since" 
                                            meta:resourcekey="Label10Resource1"></asp:Label>
                                        <asp:TextBox ID="txtQuitAlc_4" onKeyDown="return  isNumeric(event,this.id)" Width="35px"
                                            runat="server" meta:resourcekey="txtQuitAlc_4Resource1"></asp:TextBox>
                                        <asp:DropDownList ID="ddlQuitAlcDuration" runat="server" 
                                            meta:resourcekey="ddlQuitAlcDurationResource1">
                                            <asp:ListItem Value="8" meta:resourcekey="ListItemResource2">year(s)</asp:ListItem>
                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource3">day(s)</asp:ListItem>
                                            <asp:ListItem Value="6" meta:resourcekey="ListItemResource4">week(s)</asp:ListItem>
                                            <asp:ListItem Value="7" meta:resourcekey="ListItemResource5">month(s)</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    </table>

<script type="text/javascript">
</script>

