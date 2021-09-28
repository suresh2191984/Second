<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Hair.ascx.cs" Inherits="HealthPackageControls_Hair" %>
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divHR1" onclick="showResponses('tcEMR_tpExamination_ucHair_divHR1','tcEMR_tpExamination_ucHair_divHR2','divHR3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Hair" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divHR2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucHair_divHR1','tcEMR_tpExamination_ucHair_divHR2','divHR3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Hair" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divHR3" style="display: none;width:100%" title="Hair">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <%-- <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblHair_915" runat="server" Text="Hair"></asp:Label>
        </td>
    </tr>--%>
    <tr id="trchkHair_915" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkHair_915" runat="server" Text="Hair" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkHair_915Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkHair_915" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 10%">
                        <asp:Label ID="lblHairType_3" runat="server" Text="Type" 
                            meta:resourcekey="lblHairType_3Resource1"></asp:Label>
                    </td>
                    <td style="width: 20%">
                        <asp:DropDownList ID="ddlHairType_3" onmouseover="maxWidth(this.id);" runat="server" 
                            meta:resourcekey="ddlHairType_3Resource1">
                        </asp:DropDownList>
                        <%--<uc8:EMR ID="EMR2" visible="true" runat="server" />--%>
                    </td>
                    <td style="width: 10%">
                        <uc8:EMR ID="EMR2" visible="true" runat="server" />
                    </td>
                    <td colspan="3"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>
