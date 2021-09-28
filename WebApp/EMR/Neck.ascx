<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Neck.ascx.cs" Inherits="HealthPackageControls_Neck" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divNK1" onclick="showResponses('tcEMR_tpExamination_ucNeck_divNK1','tcEMR_tpExamination_ucNeck_divNK2','divNK3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Neck" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNK2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucNeck_divNK1','tcEMR_tpExamination_ucNeck_divNK2','divNK3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Neck" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNK3" style="display: none;width:100%" title="Neck">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblNeck_874" runat="server" Text="Neck" 
                meta:resourcekey="lblNeck_874Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkThyroidGland_875" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkThyroidGland_875" runat="server" Text="Thyroid Gland" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkThyroidGland_875Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkThyroidGland_875" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_39" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_39Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_39" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_39_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_39Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR1" visible="true" runat="server" />
                            </td>
                            <td id="trType_39" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_40" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_40Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_40" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_40_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_40Resource1">
                                </asp:DropDownList>
                                <td id="tdType_39" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR2" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_40" runat="server" style="display: none">
                                    <asp:TextBox ID="txtAbnormalitiesOthers_129" runat="server" 
                                        meta:resourcekey="txtAbnormalitiesOthers_129Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_39" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkLymphNodes_876" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkLymphNodes_876" runat="server" Text="Lymph Nodes" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkLymphNodes_876Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkLymphNodes_876" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="lblType_41" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_41Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_41" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_41_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_41Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR3" visible="true" runat="server" />
                            </td>
                            <td id="trType_41" runat="server" style="display: none;">
                                <asp:Label ID="lblLocation_42" runat="server" Text="Location" 
                                    meta:resourcekey="lblLocation_42Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlLocation_42" runat="server" 
                                    meta:resourcekey="ddlLocation_42Resource1">
                                </asp:DropDownList>
                            </td>
                            <td id="tdType_41" runat="server" style="display: none;">
                                <uc8:EMR ID="EMR4" visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_41" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div>
