<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Ear.ascx.cs" Inherits="HealthPackageControls_Ear" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divER1" onclick="showResponses('tcEMR_tpExamination_ucEar_divER1','tcEMR_tpExamination_ucEar_divER2','divER3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Ear" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divER2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucEar_divER1','tcEMR_tpExamination_ucEar_divER2','divER3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Ear" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divER3" style="display: none;width:100%" title="Ear">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblEye_871" runat="server" Text="Ear" meta:resourcekey="lblEye_871Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkAuditoryCanal_872" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkAuditoryCanal_872" runat="server" Text="Auditory Canal" onclick="javascript:showExamPKGContents(this.id);"
                            meta:resourcekey="chkAuditoryCanal_872Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="defaultfontcolor" id="tr1chkAuditoryCanal_872" runat="server" style="display: none">
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr id="trEar" style="display: block">
                    <td style="width: 70px">
                        <asp:Label ID="lblRightEar_35" runat="server" Text="Right Ear" meta:resourcekey="lblRightEar_35Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRightEar_35" onchange="javascript:showExamPKGOthers(this.id);"
                            runat="server" meta:resourcekey="ddlRightEar_35Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR1" Visible="true" runat="server" />
                    </td>
                    <td id="divddlRightEar_35" runat="server" style="display: none">
                        <asp:TextBox ID="txtRightEarOthers_110" runat="server" meta:resourcekey="txtRightEarOthers_110Resource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblLeftEar_36" runat="server" Text="Left Ear" meta:resourcekey="lblLeftEar_36Resource1"></asp:Label>
                        <asp:DropDownList ID="ddlLeftEar_36" onchange="javascript:showExamPKGOthers(this.id);"
                            runat="server" meta:resourcekey="ddlLeftEar_36Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                    </td>
                    <td id="divddlLeftEar_36" runat="server" style="display: none">
                        <asp:TextBox ID="txtLeftEarOthers_114" runat="server" meta:resourcekey="txtLeftEarOthers_114Resource1"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkEarDrum_873" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkEarDrum_873" runat="server" Text="Ear Drum" onclick="javascript:showExamPKGContents(this.id);"
                            meta:resourcekey="chkEarDrum_873Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkEarDrum_873" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td>
                        <asp:Label ID="lblRightEar_37" runat="server" Text="Right Ear" meta:resourcekey="lblRightEar_37Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRightEar_37" runat="server" 
                            meta:resourcekey="ddlRightEar_37Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR3" Visible="true" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblLeftEar_38" runat="server" Text="Left Ear" meta:resourcekey="lblLeftEar_38Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlLeftEar_38" runat="server" meta:resourcekey="ddlLeftEar_38Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR4" Visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table> 
</div> 