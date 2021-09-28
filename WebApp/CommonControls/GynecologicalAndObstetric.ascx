<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GynecologicalAndObstetric.ascx.cs"
    Inherits="CommonControls_GynecologicalAndObstetric" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table>
    <tr>
        <td style="width: 200px">
            <asp:Label ID="lblGynacHis_1065" runat="server" Text="Gynaecological And Obstetric History" Font-Bold="true"></asp:Label>
        </td>
        <td align="left" colspan="1">
            <asp:RadioButton ID="rdoYes_1065" Text="Yes" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" />
            <asp:RadioButton ID="rdoNo_1065" Text="No" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" />
            <asp:RadioButton ID="rdoUnknown_1065" Text="Unknown" runat="server" GroupName="radioExtend"
                onclick="javascript:showContentHis(this.id);" />
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1065" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td>
                            <%--<table cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                <tr>
                                    <td>--%>
                                        <asp:Label ID="lblLMPDate" runat="server" CssClass="defaultfontcolor" Text="LMP Date"
                                            meta:resourcekey="lblLMPDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tLMP_38" runat="server" Style="text-align: justify"
                                            TabIndex="4" ValidationGroup="MKE" meta:resourcekey="tLMP_38Resource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="tLMP_38" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                            TargetControlID="tLMP_38" Enabled="True" />
                                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            meta:resourcekey="ImgBntCalcResource1" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                            ControlToValidate="tLMP_38" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMenstrualCycle" runat="server" CssClass="defaultfontcolor" Text="Menstrual Cycle"
                                            meta:resourcekey="lblMenstrualCycleResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlMenstrualCycle" runat="server" meta:resourcekey="ddlMenstrualCycleResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR22" Visible="true" runat="server" />
                                        </td>--%>
                                    <td>
                                        <asp:Label ID="lblCycleLength" runat="server" CssClass="defaultfontcolor" Text="Cycle Length(approx)"
                                            meta:resourcekey="lblCycleLengthResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCycleLength_45" runat="server" Width="50px" meta:resourcekey="txtCycleLength_45Resource1"></asp:TextBox>
                                        <asp:Label ID="lblCyclelengthDays" runat="server" CssClass="defaultfontcolor" Text="days"
                                            meta:resourcekey="lblCyclelengthDaysResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkPregnant" runat="server" Text="Pregnant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkFeeding" runat="server" Text="Breast Feeding" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAgeofMenarchy" runat="server" CssClass="defaultfontcolor" Text="Age of Menarche"
                                            meta:resourcekey="lblAgeofMenarchyResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAgeofMenarchy_47" runat="server" meta:resourcekey="txtAgeofMenarchy_47Resource1"></asp:TextBox>
                                        <asp:Label ID="lblAgeofMenarchyYears" runat="server" CssClass="defaultfontcolor"
                                            Text="years" meta:resourcekey="lblAgeofMenarchyYearsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblContraception" runat="server" CssClass="defaultfontcolor" Text="Contraception"
                                            meta:resourcekey="lblContraceptionResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlContraception_50" Width="142px" onchange="javascript:showOthersBoxHis(this.id);"
                                            runat="server" meta:resourcekey="ddlContraception_50Resource1">
                                        </asp:DropDownList>
                                        <div id="divddlContraception_50" runat="server" style="display: none">
                                            <asp:TextBox ID="txtContraceptionOthers_50" runat="server" Width="75px" meta:resourcekey="txtContraceptionOthers_50Resource1"></asp:TextBox>
                                        </div>
                                    </td>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR23" Visible="true" runat="server" />
                                        </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLastPapSmear" runat="server" CssClass="defaultfontcolor" Text="Last Pap Smear"
                                            meta:resourcekey="lblLastPapSmearResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastPapSmearDt_46" runat="server" 
                                            Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" meta:resourcekey="txtLastPapSmearDt_46Resource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtLastPapSmearDt_46" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton1"
                                            TargetControlID="txtLastPapSmearDt_46" Enabled="True" />
                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            meta:resourcekey="ImageButton1Resource1" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                            ControlToValidate="txtLastPapSmearDt_46" Display="Dynamic" EmptyValueBlurredText="*"
                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator3"
                                            meta:resourcekey="MaskedEditValidator3Resource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPapSmearResult" runat="server" CssClass="defaultfontcolor" Text="Last ParSmear Result"
                                            meta:resourcekey="lblPapSmearResultResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLastPapSmearResult" Width="142px" runat="server" meta:resourcekey="ddlLastPapSmearResultResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR24" Visible="true" runat="server" />
                                        </td>--%>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLastMamogram" runat="server" CssClass="defaultfontcolor" Text="Last Mammogram"
                                            meta:resourcekey="lblLastMamogramResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastMammogramResultDt_55" runat="server" meta:resourcekey="txtLastMammogramResultDt_55Resource1"></asp:TextBox>
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtLastMammogramResultDt_55" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton2"
                                            TargetControlID="txtLastMammogramResultDt_55" Enabled="True" />
                                        <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            meta:resourcekey="ImageButton2Resource1" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                            ControlToValidate="txtLastMammogramResultDt_55" Display="Dynamic" EmptyValueBlurredText="*"
                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1"
                                            meta:resourcekey="MaskedEditValidator1Resource1" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblLastMamogramResult" runat="server" CssClass="defaultfontcolor"
                                            Text="Last Mamogram Result" meta:resourcekey="lblLastMamogramResultResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLastMamogramResult" Width="142px" runat="server" meta:resourcekey="ddlLastMamogramResultResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTypeofHRT" runat="server" CssClass="defaultfontcolor" Text="Type of HRT"
                                            meta:resourcekey="lblTypeofHRTResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTypeofHRT_59" onchange="javascript:showOthersBoxHis(this.id);"
                                            runat="server" meta:resourcekey="ddlTypeofHRT_59Resource1">
                                        </asp:DropDownList>
                                    </td>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR27" Visible="true" runat="server" />
                                        </td>--%>
                                    <td>
                                        <asp:Label ID="lblHRTDelivery" runat="server" CssClass="defaultfontcolor" Text="HRT Delivery"
                                            meta:resourcekey="lblHRTDeliveryResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlHRTDelivery_66" Width="142px" onchange="javascript:showOthersBoxHis(this.id);"
                                            runat="server" meta:resourcekey="ddlHRTDelivery_66Resource1">
                                        </asp:DropDownList>
                                    </td>
                                    <%--<td style="display:none">
                                            <uc8:EMR ID="EMR28" Visible="true" runat="server" />
                                        </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <div id="divddlTypeofHRT_59" runat="server" style="display: none">
                                            <asp:TextBox ID="txtOthersTypeofHRT_59" runat="server" meta:resourcekey="txtOthersTypeofHRT_59Resource1"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <div id="divddlHRTDelivery_66" runat="server" style="display: none">
                                            <asp:TextBox ID="txtOthersHRTDelivery_66" runat="server" meta:resourcekey="txtOthersHRTDelivery_66Resource1"></asp:TextBox>
                                        </div>
                                    <%--</td>
                                </tr>
                            </table>--%>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<%-- </table>--%>
<%--</div>
--%>