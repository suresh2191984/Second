<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Skin.ascx.cs" Inherits="HealthPackageControls_Skin" %>
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divGSK1" onclick="showResponses('tcEMR_tpExamination_ucSkin_divGSK1','tcEMR_tpExamination_ucSkin_divGSK2','divGSK3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="General Signs" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divGSK2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucSkin_divGSK1','tcEMR_tpExamination_ucSkin_divGSK2','divGSK3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="General Signs" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divGSK3" style="display: none;width:100%" title="General Signs">
<table border="0" cellpadding="0" width="100%"  class="dataheaderInvCtrl">
     <tr>
            <td valign="top">
                <asp:Label ID="lblSignName" Text="GENERAL SIGNS" runat="server"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtSign" runat="server" MaxLength="3" size="5" Width="221px" Height="68px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
</table>
</div>
<div id="divSK1" onclick="showResponses('tcEMR_tpExamination_ucSkin_divSK1','tcEMR_tpExamination_ucSkin_divSK2','divSK3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Skins" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divSK2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucSkin_divSK1','tcEMR_tpExamination_ucSkin_divSK2','divSK3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Skins" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divSK3" style="display: none;width:100%" title="Skins">
<table border="0" cellpadding="0" width="100%"  class="dataheaderInvCtrl">
    <%--<tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblSkin_928" runat="server" Text="Skin"></asp:Label>
        </td>
    </tr>--%>
    
    <tr id="trchkSkin_928" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkSkin_928" runat="server" Text="Skin" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkSkin_928Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkSkin_928" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 100px">
                        <asp:Label ID="lblSkinType_1" runat="server" Text="Type" 
                            meta:resourcekey="lblSkinType_1Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <asp:DropDownList ID="ddlSkinType_1" runat="server" onmouseover="maxWidth(this.id);" 
                            meta:resourcekey="ddlSkinType_1Resource1">
                        </asp:DropDownList>
                        <%--<uc8:EMR ID="EMR1" Visible="false"  runat="server" />--%>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR1" Visible="true"  runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblSkinLesions_2" runat="server" Text="Skin Lesions" 
                            meta:resourcekey="lblSkinLesions_2Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSkinLesions_2" onchange="javascript:showExamPKGOthers(this.id);"
                            runat="server" onmouseover="maxWidth(this.id);"
                            meta:resourcekey="ddlSkinLesions_2Resource1">
                        </asp:DropDownList>
                        <div id="divddlSkinLesions_2" runat="server" style="display: none">
                            <asp:TextBox ID="txtSkinLesionsOthers_19" runat="server" 
                                meta:resourcekey="txtSkinLesionsOthers_19Resource1"></asp:TextBox>
                        </div>
                        <%--<uc8:EMR ID="EMR2" Visible="false" runat="server" />--%>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>
<%--</ContentTemplate>
</asp:UpdatePanel>--%>