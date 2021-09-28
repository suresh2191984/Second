<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Nails.ascx.cs" Inherits="HealthPackageControls_Nails" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divNL1" onclick="showResponses('tcEMR_tpExamination_ucNails_divNL1','tcEMR_tpExamination_ucNails_divNL2','divNL3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Rs_ReferringPhysician" Text="Nails" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNL2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucNails_divNL1','tcEMR_tpExamination_ucNails_divNL2','divNL3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Rs_ReferringPhysician1" Text="Nails" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNL3" style="display: none;width:100%" title="Nails">
    <table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
        <%-- <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblNails_916" runat="server" Text="Nails"></asp:Label>
        </td>
    </tr>--%>
        <tr id="trchkNails_916" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkNails_916" runat="server" Text="Nails" onclick="javascript:showExamPKGContents(this.id);"
                                meta:resourcekey="chkNails_916Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkNails_916" runat="server" style="display: none;">
            <td>
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td style="width: 10%">
                            <asp:Label ID="lblNailsType_4" runat="server" Text="Type" meta:resourcekey="lblNailsType_4Resource1"></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:DropDownList ID="ddlNailsType_4" onmouseover="maxWidth(this.id);" onchange="javascript:showExamPKGOthers(this.id);"
                                runat="server" meta:resourcekey="ddlNailsType_4Resource1">
                            </asp:DropDownList>
                            <%--<uc8:EMR ID="EMR2" visible="false" runat="server" />--%>
                        </td>
                        <td style="width: 10%">
                            <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                        </td>
                        <td id="divddlNailsType_4" runat="server" style="display: none">
                            <asp:TextBox ID="txtNailsTypeOthers_34" runat="server" meta:resourcekey="txtNailsTypeOthers_34Resource1"></asp:TextBox>
                        </td>
                        <td id="trNailsDescription_5" runat="server" style="display: none;">
                            <asp:Label ID="lblNailsDescription_5" runat="server" Text="Description" meta:resourcekey="lblNailsDescription_5Resource1"></asp:Label>
                            <asp:TextBox ID="txtNailsDescription_422" runat="server" meta:resourcekey="txtNailsDescription_422Resource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
