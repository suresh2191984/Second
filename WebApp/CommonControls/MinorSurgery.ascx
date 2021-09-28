<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MinorSurgery.ascx.cs" Inherits="CommonControls_MinorSurgery" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">

    </script>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trMinorSurgery" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblMinorSurgery_974" runat="server" Text="Minor Surgery" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_974" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_974" Text="No" runat="server" Checked="true" GroupName="radioExtend" onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_974" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_974" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                     <tr>
                            <td>
                                <asp:Label ID="lblSurgeryName_22" runat="server" Text="Surgery Name" meta:resourcekey="lblSurgeryName_22Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDate_23" runat="server" Text="Date" meta:resourcekey="lblDate_23Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="LblHospital_24" runat="server" Text="Hospital/Centre" meta:resourcekey="LblHospital_24Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtsurgeryName" runat="server" meta:resourcekey="txtsurgeryNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtsurgeryName"
                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getSurgeryName"
                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDate" runat="server" ValidationGroup="MKE" meta:resourcekey="txtDateResource1"></asp:TextBox>
                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtDate" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton3"
                                    TargetControlID="txtDate" Enabled="True" />
                                <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    meta:resourcekey="ImageButton3Resource1" />
                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                    ControlToValidate="txtDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtHospital" runat="server" meta:resourcekey="txtHospitalResource1"></asp:TextBox>
                                <input type="button" name="btnIPTreatmentPlanAdd" id="btnSurgeryAdd" onclick="onClickAddSurgery('minor');"
                                    value="Add" class="btn" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <input type="hidden" id="hdnSurgeryItems" runat="server" />
                                <table id="tblSurgeryItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                    cellspacing="0" border="0" width="97%">
                                </table>
                            </td>
                        </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
