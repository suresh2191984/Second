<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Dyslipidemia.ascx.cs"
    Inherits="HealthPackageControls_Dyslipidemia" %>
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
    <%--Dyslipidemia Disease--%>
    <tr class="defaultfontcolor" id="trchkRaisedCholestrol_409" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblRaisedCholestrol_409" runat="server" Text="Dyslipidemia"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_409" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_409" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_409" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1rdoYes_409" runat="server" style="display: block;">
        <td colspan="2">
            <div id="divrdoYes_409" runat="server" style="display: none">
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td>
                            <asp:Label ID="lblDuration_12" runat="server" Text="Duration" meta:resourcekey="lblDuration_12Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtduration_12" runat="server" Width="50px" meta:resourcekey="txtduration_12Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlduration_12" runat="server" meta:resourcekey="ddlduration_12Resource1">
                                <asp:ListItem Text="Year(s)" Value="37" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Month(s)" Value="38" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="Week(s)" Value="39" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
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