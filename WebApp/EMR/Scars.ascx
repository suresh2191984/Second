<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Scars.ascx.cs" Inherits="HealthPackageControls_Scars" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>

<div id="divSC1" onclick="showResponses('tcEMR_tpExamination_ucScars_divSC1','tcEMR_tpExamination_ucScars_divSC2','divSC3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label1" Text="Scar" Font-Bold="True" runat="server" />
</div>
<div id="divSC2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucScars_divSC1','tcEMR_tpExamination_ucScars_divSC2','divSC3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label2" Text="Scar" Font-Bold="True" runat="server" />
</div>
<div id="divSC3" style="display: none; width: 100%" title="Scar">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <%--<tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblScar_917" runat="server" Text="Scar"></asp:Label>
        </td>
    </tr>--%>
    <tr id="trchkScar_917" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkScar_917" runat="server" Text="Scar" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkScar_917Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkScar_917" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="lblScarType_6" runat="server" Text="Type" 
                                    meta:resourcekey="lblScarType_6Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlScarType_6" runat="server" onmouseover="maxWidth(this.id);" AutoPostBack="True"
                                     OnSelectedIndexChanged = "ddlScarType_6_SelectedIndexChanged"
                                    meta:resourcekey="ddlScarType_6Resource1">
                                </asp:DropDownList>
                                <%--<uc8:EMR ID="EMR2"  visible="false" runat="server" />--%>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR2"  visible="true" runat="server" />
                            </td>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr id="trScarType_6" runat="server" style="display: none;">
                            <td runat="server">
                                <asp:Label ID="lblScaretiology_7" runat="server" Text="Scar Lesions"></asp:Label>
                            </td>
                            <td runat="server">
                                <asp:DropDownList ID="ddlScaretiology_7" onmouseover="maxWidth(this.id);" onchange="javascript:showExamPKGOthers(this.id);"
                                    runat="server">
                                </asp:DropDownList>
                                <div id="divddlScaretiology_7" runat="server" style="display: none">
                                    <asp:TextBox ID="txtScaretiologyOthers_7" runat="server"></asp:TextBox>
                                </div>
                                <%--<uc8:EMR ID="EMR3" visible="false" runat="server" />--%>
                            </td>
                            <td runat="server">
                                <uc8:EMR ID="EMR3" visible="true" runat="server" />
                            </td>
                            <td runat="server">
                                <asp:Label ID="lblScarLocation_8" runat="server" Text="Scar Location"></asp:Label>
                            </td>
                            <td runat="server">
                                <asp:TextBox ID="txtScarLocation_38" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlScarType_6" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div>
