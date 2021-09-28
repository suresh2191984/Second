<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DrugTherapy .ascx.cs" Inherits="CommonControls_DrugTherapy" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td colspan="3">
                        <asp:CheckBox ID="chkDrugTherapy" runat="server" Text="Drug Therapy" onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td colspan="2">
            <div id="divchkAsthma_246" runat="server" style="display: none">
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblDuration_16" runat="server" Text="Duration" meta:resourcekey="lblDuration_16Resource1"></asp:Label>
                        </td>
                        <td colspan="6">
                            <asp:Label ID="lblTreatment_17" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_17Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtDuration_16" runat="server" Width="50px" onKeyDown="return  isNumeric(event,this.id)"
                                meta:resourcekey="txtDuration_16Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlDuration_16" runat="server" meta:resourcekey="ddlDuration_16Resource1">
                            </asp:DropDownList>
                        </td>
                       <%-- <td colspan="2" style="display: none">
                            <uc8:emr id="EMR31" visible="true" runat="server" />
                        </td>--%>
                        <td>
                            <asp:DropDownList ID="ddlTratment_17" runat="server" meta:resourcekey="ddlTratment_17Resource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td style="display: none">
                            <uc8:emr id="EMR12" visible="true" runat="server" />
                        </td>--%>
                        <td>
                            <asp:CheckBox ID="chkExacerbations_18" runat="server" onClick="ExacerClick();" Text="Exacerbations"
                                meta:resourcekey="chkExacerbations_18Resource1" />
                        </td>
                        <td id="tdExacer" style="display: none;" runat="server">
                            <asp:Label ID="lblTimesper_18" runat="server" Text="Times per" meta:resourcekey="lblTimesper_18Resource1"></asp:Label>
                            <asp:TextBox ID="txtTimes_18" runat="server" meta:resourcekey="txtTimes_18Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlExacerbations_18" runat="server" meta:resourcekey="ddlExacerbations_18Resource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td id="tdExacerEMR" style="display: none;" runat="server">
                            <uc8:emr id="EMR13" visible="true" runat="server" />
                        </td>--%>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
