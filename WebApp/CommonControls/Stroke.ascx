<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Stroke.ascx.cs" Inherits="CommonControls_Stroke" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trStroke" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblStroke_438" runat="server" Text="Stroke/CVA" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_438" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_438" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_438" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_438" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblDate_8" runat="server" Text="Date" meta:resourcekey="lblDate_8Resource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblRecovery_9" runat="server" Text="Recovery" meta:resourcekey="lblRecovery_9Resource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblTypeOfCVA_10" runat="server" Text="TypeOfCVA" meta:resourcekey="lblTypeOfCVA_10Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLobeaffected_11" runat="server" Text="Area/Lobe affected" meta:resourcekey="lblLobeaffected_11Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtDate_30" runat="server" ValidationGroup="MKE" meta:resourcekey="txtDate_30Resource1"></asp:TextBox>
                            <ajc:maskededitextender id="MaskedEditExtender4" runat="server" errortooltipenabled="True"
                                mask="99/99/9999" masktype="Date" targetcontrolid="txtDate_30" cultureampmplaceholder=""
                                culturecurrencysymbolplaceholder="" culturedateformat="" culturedateplaceholder=""
                                culturedecimalplaceholder="" culturethousandsplaceholder="" culturetimeplaceholder=""
                                enabled="True" />
                            <ajc:calendarextender id="CalendarExtender1" runat="server" format="dd/MM/yyyy" popupbuttonid="ImageButton2"
                                targetcontrolid="txtDate_30" enabled="True" />
                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                meta:resourcekey="ImageButton2Resource1" />
                            <ajc:maskededitvalidator id="MaskedEditValidator4" runat="server" controlextender="MaskedEditExtender4"
                                controltovalidate="txtDate_30" display="Dynamic" emptyvalueblurredtext="*" emptyvaluemessage="Date is required"
                                invalidvalueblurredmessage="*" invalidvaluemessage="Date is invalid" tooltipmessage="(dd-mm-yyyy)"
                                validationgroup="MKE" errormessage="MaskedEditValidator4" meta:resourcekey="MaskedEditValidator4Resource1" />
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlRecovery_9" runat="server" meta:resourcekey="ddlRecovery_9Resource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td style="display: none">
                            <uc8:emr id="EMR7" visible="true" runat="server" />
                        </td>--%>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlTypeOfCVA_10" runat="server" meta:resourcekey="ddlTypeOfCVA_10Resource1">
                            </asp:DropDownList>
                        </td>
                       <%-- <td style="display: none">
                            <uc8:emr id="EMR8" visible="true" runat="server" />
                        </td>--%>
                        <td>
                            <asp:TextBox ID="txtLobeaffected_36" runat="server" meta:resourcekey="txtLobeaffected_36Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
