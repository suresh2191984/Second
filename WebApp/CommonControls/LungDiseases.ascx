<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LungDiseases.ascx.cs"
    Inherits="CommonControls_LungDiseases" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   function showCheckContentHis(id)
   {
     var ddl = id.split('_');
     var divid = ddl[0] + '_' + ddl[1] +'_div' + ddl[ddl.length - 2] + '_' + ddl[ddl.length - 1];
     if(document.getElementById(id).checked == true)
     {
          document.getElementById(divid).style.display="Block";
     }
     else{
          document.getElementById(divid).style.display="none";
     }
   }
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trLungDiseases" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblLungDiseases_959" runat="server" Text="Asthma/COPD" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_959" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_959" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_959" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_959" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <%--<tr>
                        <td colspan="3">
                            <asp:CheckBox ID="chkAsthma_246" Text="Asthma/COPD" runat="server" onclick="javascript:showCheckContentHis(this.id);">
                            </asp:CheckBox
                            <asp:CheckBox ID="chkTuberculosis" Text="Tuberculosis" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divchkAsthma_246" runat="server" style="display: none">
                                <table border="1" cellpadding="0" align="left" width="100%" class="dataheaderInvCtrl">--%>
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
                        <td>
                            <asp:DropDownList ID="ddlTratment_17" runat="server" meta:resourcekey="ddlTratment_17Resource1">
                            </asp:DropDownList>
                        </td>
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
                    </tr>
                    <%--</table>
                            </div>
                        </td>
                    </tr>--%>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
