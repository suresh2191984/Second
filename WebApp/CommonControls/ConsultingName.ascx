<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConsultingName.ascx.cs"
    Inherits="CommonControls_ConsultingName" %>
<table class="defaultfontcolor w-80p">
    <tr>
        <td>
            <asp:UpdatePanel ID="pnlSpeciality" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblSpeciality" runat="server" Text="Speciality" meta:resourcekey="lblSpecialityResource1"></asp:Label>&nbsp;&nbsp;
                    <asp:DropDownList ID="ddlSpeciality" CssClass="ddlTheme12" runat="server" AutoPostBack="True"
                        OnSelectedIndexChanged="ddlSpeciality_SelectedIndexChanged" meta:resourcekey="ddlSpecialityResource1">
                  
                    </asp:DropDownList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
        <td>
            <div id="divConsultingName" class="paddingL12">
                <asp:UpdatePanel ID="pnlConsulting" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="Rs_DR" runat="server" Text="DR." meta:resourcekey="Rs_DRResource1"></asp:Label>
                        <asp:DropDownList ID="ddlConsultingName" CssClass="ddlTheme12" runat="server" 
                            OnChange="SelectAllActive(this.id);" meta:resourcekey="ddlConsultingNameResource1">
                           
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <!-- OnSelectedIndexChanged="ddlConsultingName_SelectedIndexChanged"> -->
        </td>
    </tr>
    <tr>
        <td colspan="2">
        </td>
    </tr>
</table>
