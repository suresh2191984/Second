<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Eye.ascx.cs" Inherits="HealthPackageControls_Eye" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divEY1" onclick="showResponses('tcEMR_tpExamination_ucEye_divEY1','tcEMR_tpExamination_ucEye_divEY2','divEY3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label1" Text="Eye" Font-Bold="True" runat="server" />
</div>
<div id="divEY2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucEye_divEY1','tcEMR_tpExamination_ucEye_divEY2','divEY3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label2" Text="Eye" Font-Bold="True" runat="server" />
</div>
<div id="divEY3" style="display: none; width: 100%" title="Eye">
    <table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                <asp:Label ID="lblEye_918" runat="server" Text="Eye" meta:resourcekey="lblEye_918Resource1"></asp:Label>
            </td>
        </tr>
        <tr id="trchkDistantVision_919" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkDistantVision_919" runat="server" Text="Distant Vision" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkDistantVision_919Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkDistantVision_919" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblType_9" runat="server" Text="Type" meta:resourcekey="lblType_9Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType_9" runat="server" meta:resourcekey="ddlType_9Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR1" Visible="true" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblRightEye_10" runat="server" Text="Right Eye" meta:resourcekey="lblRightEye_10Resource1"></asp:Label>
                            <asp:TextBox ID="txtRightEye_10" runat="server" meta:resourcekey="txtRightEye_10Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblLeftEye_97" runat="server" Text="Left Eye" meta:resourcekey="lblLeftEye_97Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLeftEye_97" runat="server" meta:resourcekey="txtLeftEye_97Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trchkNearVision_920" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkNearVision_920" runat="server" Text="Near Vision" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkNearVision_920Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkNearVision_920" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblType_11" runat="server" Text="Type" meta:resourcekey="lblType_11Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType_11" runat="server" meta:resourcekey="ddlType_11Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblRightEye_12" runat="server" Text="Right Eye" meta:resourcekey="lblRightEye_12Resource1"></asp:Label>
                            <asp:TextBox ID="txtRightEye_12" runat="server" meta:resourcekey="txtRightEye_12Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblLeftEye_99" runat="server" Text="Left Eye" meta:resourcekey="lblLeftEye_99Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLeftEye_99" runat="server" meta:resourcekey="txtLeftEye_99Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trchkColorVision_921" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkColorVision_921" runat="server" Text="Color Vision" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkColorVision_921Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkColorVision_921" runat="server" style="display: none;">
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                            <tr>
                                <td style="width: 50px">
                                    <asp:Label ID="lblType_13" runat="server" Text="Type" meta:resourcekey="lblType_13Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlType_13" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlType_13_SelectedIndexChanged"
                                        meta:resourcekey="ddlType_13Resource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR3" Visible="true" runat="server" />
                                </td>
                                <td id="trType_13" runat="server" style="display: none;">
                                    <asp:Label ID="lblDescription_14" runat="server" Text="Description" meta:resourcekey="lblDescription_14Resource1"></asp:Label>
                                    <asp:DropDownList ID="ddlDescription_14" onchange="javascript:showExamPKGOthers(this.id);"
                                        runat="server" meta:resourcekey="ddlDescription_14Resource1">
                                    </asp:DropDownList>
                                    <td id="EMRType_13" runat="server" style="display: none;">
                                        <uc8:EMR ID="EMR4" Visible="true" runat="server" />
                                    </td>
                                    <td id="divddlDescription_14" runat="server" style="display: none">
                                        <asp:TextBox ID="txtDescriptionOthers_57" runat="server" meta:resourcekey="txtDescriptionOthers_57Resource1"></asp:TextBox>
                                    </td>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlType_13" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr id="trchkIOLPresent_922" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkIOLPresent_922" runat="server" Text="IOL Present" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkIOLPresent_922Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkIOLPresent_922" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblEyes_15" runat="server" Text="Eyes" meta:resourcekey="lblEyes_15Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlEyes_15" runat="server" meta:resourcekey="ddlEyes_15Resource1">
                                <asp:ListItem Text="Right" Value="58" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Left" Value="59" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="Both" Value="60" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trchkPterygium_923" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkPterygium_923" runat="server" Text="Pterygium" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkPterygium_923Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkPterygium_923" runat="server" style="display: none;">
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                            <tr>
                                <td style="width: 50px">
                                    <asp:Label ID="lblType_16" runat="server" Text="Type" meta:resourcekey="lblType_16Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlType_16" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlType_16_SelectedIndexChanged"
                                        meta:resourcekey="ddlType_16Resource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR5" Visible="true" runat="server" />
                                </td>
                                <td id="trType_16" runat="server" style="display: none;">
                                    <asp:Label ID="lblDescription_17" runat="server" Text="Description" meta:resourcekey="lblDescription_17Resource1"></asp:Label>
                                    <asp:TextBox ID="txtDescription_65" runat="server" meta:resourcekey="txtDescription_65Resource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlType_16" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr id="trchkXanthelasma_924" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkXanthelasma_924" runat="server" Text="Xanthelasma" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkXanthelasma_924Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkXanthelasma_924" runat="server" style="display: none;">
            <td>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                            <tr>
                                <td style="width: 50px">
                                    <asp:Label ID="lblType_18" runat="server" Text="Type" meta:resourcekey="lblType_18Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlType_18" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlType_18_SelectedIndexChanged"
                                        meta:resourcekey="ddlType_18Resource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR6" Visible="true" runat="server" />
                                </td>
                                <td id="trType_18" runat="server" style="display: none;">
                                    <asp:Label ID="lblAssociatedConditions_19" runat="server" Text="Associated Conditions"
                                        meta:resourcekey="lblAssociatedConditions_19Resource1"></asp:Label>
                                    <asp:DropDownList ID="ddlAssociatedConditions_19" runat="server" onClick="javascript:showExamPKGOthers(this.id);"
                                        meta:resourcekey="ddlAssociatedConditions_19Resource1">
                                    </asp:DropDownList>
                                    <td id="EMRType_18" runat="server" style="display: none;">
                                        <uc8:EMR ID="EMR13" Visible="true" runat="server" />
                                    </td>
                                    <td id="divddlAssociatedConditions_19" runat="server" style="display: none">
                                        <asp:TextBox ID="txtAssociatedConditions_74" runat="server" meta:resourcekey="txtAssociatedConditions_74Resource1"></asp:TextBox>
                                    </td>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlType_18" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr id="trchkEyeMovements_925" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkEyeMovements_925" runat="server" Text="Eye Movements" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkEyeMovements_925Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkEyeMovements_925" runat="server" style="display: none;">
            <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                            <tr>
                                <td style="width: 50px">
                                    <asp:Label ID="lblType_20" runat="server" Text="Type" meta:resourcekey="lblType_20Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlType_20" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlType_20_SelectedIndexChanged"
                                        meta:resourcekey="ddlType_20Resource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR7" Visible="true" runat="server" />
                                </td>
                                <td id="trType_20" runat="server" style="display: none;">
                                    <asp:Label ID="lblAbnormality_21" runat="server" Text="Abnormality" meta:resourcekey="lblAbnormality_21Resource1"></asp:Label>
                                    <asp:DropDownList ID="ddlAbnormality_21" runat="server" onClick="javascript:showExamPKGOthers(this.id);"
                                        meta:resourcekey="ddlAbnormality_21Resource1">
                                    </asp:DropDownList>
                                    <td id="EMRType_20" runat="server" style="display: none;">
                                        <uc8:EMR ID="EMR14" Visible="true" runat="server" />
                                    </td>
                                    <td id="divddlAbnormality_21" runat="server" style="display: none">
                                        <asp:TextBox ID="txtAbnormality_86" runat="server" meta:resourcekey="txtAbnormality_86Resource1"></asp:TextBox>
                                    </td>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlType_20" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr id="trchkPupils_926" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkPupils_926" runat="server" Text="Pupils" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkPupils_926Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkPupils_926" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblSize_22" runat="server" Text="Size" meta:resourcekey="lblSize_22Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRightEye_23" runat="server" Text="Right Eye" meta:resourcekey="lblRightEye_23Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRightEye_23" runat="server" meta:resourcekey="txtRightEye_23Resource1"></asp:TextBox>
                            <asp:Label ID="lblUOM_23" runat="server" Text="mm" meta:resourcekey="lblUOM_23Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLeftEye_24" runat="server" Text="Left Eye" meta:resourcekey="lblLeftEye_24Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLeftEye_24" runat="server" meta:resourcekey="txtLeftEye_24Resource1"></asp:TextBox>
                            <asp:Label ID="lblUOM_24" runat="server" Text="mm" meta:resourcekey="lblUOM_24Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblShape_25" runat="server" Text="Shape" meta:resourcekey="lblShape_25Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRightEye_26" runat="server" Text="Right Eye" meta:resourcekey="lblRightEye_26Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlRightEye_26" runat="server" meta:resourcekey="ddlRightEye_26Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR8" Visible="true" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblLeftEye_27" runat="server" Text="Left Eye" meta:resourcekey="lblLeftEye_27Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlLeftEye_27" runat="server" meta:resourcekey="ddlLeftEye_27Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR12" Visible="true" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblReactiontoLight_28" runat="server" Text="Reaction to Light" meta:resourcekey="lblReactiontoLight_28Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRightEye_29" runat="server" Text="Right Eye" meta:resourcekey="lblRightEye_29Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlRightEye_29" runat="server" meta:resourcekey="ddlRightEye_29Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR9" Visible="true" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblLeftEye_30" runat="server" Text="Left Eye" meta:resourcekey="lblLeftEye_30Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlLeftEye_30" runat="server" meta:resourcekey="ddlLeftEye_30Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <uc8:EMR ID="EMR10" Visible="true" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblAbnormalities_31" runat="server" Text="Abnormalities" meta:resourcekey="lblAbnormalities_31Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlAbnormalities_31" onchange="javascript:showExamPKGOthers(this.id);"
                                runat="server" meta:resourcekey="ddlAbnormalities_31Resource1">
                            </asp:DropDownList>
                            <uc8:EMR ID="EMR11" Visible="true" runat="server" />
                            <td id="divddlAbnormalities_31" runat="server" style="display: none">
                                <asp:TextBox ID="txtAbnormalitiesOthers_100" runat="server" meta:resourcekey="txtAbnormalitiesOthers_100Resource1"></asp:TextBox>
                            </td>
                        </td>
                        <td>
                            <asp:Label ID="lblDescription_32" runat="server" Text="Description" meta:resourcekey="lblDescription_32Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescription_32" runat="server" meta:resourcekey="txtDescription_32Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trchkTonometry_927" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkTonometry_927" runat="server" Text="Tonometry" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkTonometry_927Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkTonometry_927" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblIOP_33" runat="server" Text="IOP" meta:resourcekey="lblIOP_33Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRightIOP_33" runat="server" Text="Right IOP" meta:resourcekey="lblRightIOP_33Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRightIOP_33" runat="server" meta:resourcekey="txtRightIOP_33Resource1"></asp:TextBox>
                            <asp:Label ID="lblUOM_33" runat="server" Text="mmHg" meta:resourcekey="lblUOM_33Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLeftIOP_34" runat="server" Text="Left IOP" meta:resourcekey="lblLeftIOP_34Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLeftIOP_34" runat="server" meta:resourcekey="txtLeftIOP_34Resource1"></asp:TextBox>
                            <asp:Label ID="lblUOM_34" runat="server" Text="mmHg" meta:resourcekey="lblUOM_34Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
