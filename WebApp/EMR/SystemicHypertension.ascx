<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SystemicHypertension.ascx.cs"
    Inherits="HealthPackageControls_SystemicHypertension" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<%--<asp:UpdatePanel ID="pnl" runat="server">
<ContentTemplate>--%>
<%--<script type ="text/javascript">
    function fn() {
        //debugger;
        alert('fn');
    }
</script>--%>
<%--<div id="divDI1" onclick="showResponses('Diab1_divDI1','Diab1_divDI2','divDI3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Diabetes Mellitus" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divDI2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('Diab1_divDI1','Diab1_divDI2','divDI3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Diabetes Mellitus" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divDI3" style="display: none;width:100%" title="Diabetes Mellitus">--%>
<table cellpadding="0" width="100%">
    <%--<tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblSkin_928" runat="server" Text="Skin"></asp:Label>
        </td>
    </tr>--%>
    <%--SystemicHypertension--%>
        <tr id="trchkHighBloodPressure_402" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td style="width: 200px">
                        <asp:Label ID="lblHighBloodPressure_402" runat="server" Text="Systemic Hypertension"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_402" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_402" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_402" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkHighBloodPressure_402" runat="server" style="display: block;">
        <td colspan="2">
            <div id="divrdoYes_402" runat="server" style="display: none">
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td colspan="3">
                            <asp:Label ID="lblDuration_1" runat="server" Text="Duration" meta:resourcekey="lblDuration_1Resource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblTreatment_2" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtDuration_1" runat="server" Width="50px" meta:resourcekey="txtDuration_1Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlDurationt_1" runat="server" meta:resourcekey="ddlDurationt_1Resource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td colspan="3">
                            <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                        </td>--%>
                        <td colspan="3">
                            <asp:CheckBoxList ID="chkTreatment_2" runat="server" RepeatDirection="Horizontal"
                                RepeatColumns="4" meta:resourcekey="chkTreatment_2Resource1">
                            </asp:CheckBoxList>
                            <asp:CheckBox ID="chkOthers_9" runat="server" Text="Others" onClick="javascript:showOthersChkBox(this.id);"
                                meta:resourcekey="chkOthers_9Resource1" />
                            <div id="divchkOthers_9" runat="server" style="display: none">
                                <asp:TextBox ID="txtOthers_9" runat="server" meta:resourcekey="txtOthers_9Resource1"></asp:TextBox>
                            </div>
                        </td>
                        <%--<td>
                            <uc8:EMR ID="EMR1" Visible="true" runat="server" />
                        </td>--%>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <%--End Dyslipidemia Disease--%>
</table>
<%--</div>
--%><%--</ContentTemplate>
</asp:UpdatePanel>--%>