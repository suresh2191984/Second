<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DiabetesMellitus.ascx.cs"
    Inherits="HealthPackageControls_DiabetesMellitus" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<%--<asp:UpdatePanel ID="pnl" runat="server">
<ContentTemplate>--%>

<%--<script type="text/javascript">
    function ddlFHODMChange(id) {
        alert(id);
        //ucDiab_ddlFHODM_1083
        var e = document.getElementById(id);
        var ddlist = id.split('_');
        alert(ddlist.length);
        var txtFHO = ddlist[0] + '_' + 'txtFHODM_1083';
//        var strDiv = ddlist[0] + '_' + 'div' + ddlist[1] + '_' + ddlist[2];
        var strID = e.options[e.selectedIndex].text;
        if (strID == "Present" || strID == "Insignificant") {
            document.getElementById(txtFHO).style.display = "block";
            document.getElementById(txtFHO).focus();

        }
        else {
            document.getElementById(txtFHO).value = '';
            document.getElementById(txtFHO).style.display = "none";
        }
    }
    
</script>
--%>
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
    <tr class="defaultfontcolor" id="trchkDiabetesMellitus_389" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblDiabetesMellitus_389" runat="server" Text="Diabetes Mellitus" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_389" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_389" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_389" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="trrdoYes_389" runat="server" style="display: none;">
        <td colspan="2">
            <div id="divrdoYes_389" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblDuration_5" runat="server" Text="Duration" meta:resourcekey="lblDuration_5Resource1"></asp:Label>
                        </td>
                        <%--                        <td visible="false" >
                        </td>--%>
                        <td colspan="2">
                            <asp:Label ID="lblType_6" runat="server" Text="Type" meta:resourcekey="lblType_6Resource1"></asp:Label>
                        </td>
                        <%--<td visible="false" >
                        </td>--%>
                        <td colspan="2">
                            <asp:Label ID="lblTreatment_7" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_7Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%" colspan="2">
                            <asp:TextBox ID="txtDuration_5" runat="server" Width="50px" meta:resourcekey="txtDuration_5Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlDuration_5" runat="server" meta:resourcekey="ddlDuration_5Resource1">
                            </asp:DropDownList>
                            <%--<uc8:EMR ID="EMR4" Visible="False" runat="server" />--%>
                        </td>
                        <%--<td style="width: 8%">
                            <uc8:EMR ID="EMR4" Visible="true" runat="server" />
                        </td>--%>
                        <td style="width: 16%" colspan="2">
                            <%-- <td visible="false" >
                            <%--<uc8:EMR ID="EMR4" Visible="False" runat="server" />
                        </td>--%>
                            <asp:DropDownList ID="ddlType_6" runat="server" meta:resourcekey="ddlType_6Resource1">
                            </asp:DropDownList>
                            <%--<uc8:EMR ID="EMR5" Visible="false" runat="server" />--%>
                        </td>
                        <%--<td style="width: 8%">
                            <uc8:EMR ID="EMR5" Visible="true" runat="server" />
                        </td>--%>
                        <td style="width: 16%" colspan="2">
                            <%--<td visible="false" >
                            <%--<uc8:EMR ID="EMR5" Visible="false" runat="server" />
                        </td>--%>
                            <asp:DropDownList ID="ddlTreatment_7" runat="server" onchange="javascript:showOthersBoxMedHis(this.id);"
                                meta:resourcekey="ddlTreatment_7Resource1">
                            </asp:DropDownList>
                            <div id="divddlTreatment_7" runat="server" style="display: none">
                                <asp:TextBox ID="txtothers_68" runat="server"></asp:TextBox>
                                <%--<uc8:EMR ID="EMR6" Visible="false" runat="server" />--%>
                            </div>
                        </td>
                        <%--<td>
                            <uc8:EMR ID="EMR6" Visible="true" runat="server" />
                        </td>--%>
                        <asp:HiddenField ID="hdnchkDiabetesMellitus_389" runat="server" />
                        <%--<td visible="false" >
                            <%--<uc8:EMR ID="EMR6" Visible="false" runat="server" />
                        </td>--%>
                        <%--<asp:Button ID ="btnSample" Text ="sample" OnClick ="btnSample_Click" runat ="server" />--%>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <table cellpadding="0" align="center" width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label25" runat="server" Text="F/H/O DM"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList ID="ddlFHODM_1083" runat="server">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:TextBox ID="txtFHODM_1083" Style="display: none;" runat="server"></asp:TextBox>
                                    </td>
                                    <%--<td>
                        <uc8:EMR ID="EMR36" Visible="true" runat="server" />
                    </td>--%>
                                </tr>
                             <%--   H/O Hypoglycemia--%>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label26" runat="server" Text="H/O Hypoglycemia"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtHOHypoglycemia_1084" runat="server"></asp:TextBox>
                                    </td>
                                    <%--<td visible="false">
                        <uc8:EMR ID="EMR37" Visible="false" runat="server" />s
                    </td>--%>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<%--</div>
--%><%--</ContentTemplate>
</asp:UpdatePanel>--%>