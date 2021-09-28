<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PVD.ascx.cs" Inherits="HealthPackageControls_PVD" %>
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
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
    <%--PVD--%>
    <tr class="defaultfontcolor">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblPVD_181" runat="server" Text="PVD"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_181" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_181" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_181" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="divrdoYes_181" runat="server" style="display: none">
                <table class="dataheaderInvCtrl" style="width: 100%;">
                    <%-- <tr>
                            <td colspan="3">
                                <asp:Label ID="Label22" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>--%>
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtPVD_181" runat="server" Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<%--End PVD--%>
<%--</div>
--%><%--</ContentTemplate>
</asp:UpdatePanel>--%>