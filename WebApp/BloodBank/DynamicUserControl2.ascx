<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicUserControl2.ascx.cs" Inherits="BloodBank_DynamicUserControl2" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor">
        <td colspan="2">
            <table cellpadding="0" width="100%">
                <tr>
                    <td style="width:200px">
                        <asp:Label ID="lblHeading" runat="server" Font-Bold="True" 
                            meta:resourcekey="lblHeadingResource1"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoYesResource1" />
                        <asp:RadioButton ID="rdoNo" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoNoResource1" />
                        <asp:RadioButton ID="rdoUnknown" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoUnknownResource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td colspan="2">
            <div id="divrdoYes" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%"  >
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblTypeofcancer_13" runat="server" Text="Type Of Cancer" meta:resourcekey="lblTypeofcancer_13Resource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblStageofcancer_14" runat="server" Text="Stage Of Cancer" meta:resourcekey="lblStageofcancer_14Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblTreatment_15" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_15Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <asp:DropDownList ID="ddlTypeofcancer_13" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                meta:resourcekey="ddlTypeofcancer_13Resource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <div id="divddlTypeofcancer_13" runat="server" style="display: none">
                                <asp:TextBox ID="txtothers_72" runat="server" meta:resourcekey="txtothers_72Resource1"></asp:TextBox>
                            </div>
                        </td>
                        <%--<td style="display:none">
                                <uc8:EMR ID="EMR9" Visible="true" runat="server" />
                            </td>--%>
                        <td style="width: 10%">
                            <asp:DropDownList ID="ddlStageofcancer_14" runat="server" meta:resourcekey="ddlStageofcancer_14Resource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td style="display:none">
                                <uc8:EMR ID="EMR11" Visible="true" runat="server" />
                            </td>--%>
                        
                            <td colspan="2">
                                <asp:DropDownList ID="ddlTreatment_15" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                    meta:resourcekey="ddlTreatment_15Resource1">
                                </asp:DropDownList>
                                <div id="divddlTreatment_15" runat="server" style="display: none">
                                    <asp:TextBox ID="txtothers_73" runat="server" meta:resourcekey="txtothers_73Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <%-- <td style="display:none">
                                    <uc8:EMR ID="EMR10" Visible="true" runat="server" />
                                </td>--%>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
