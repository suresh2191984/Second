<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RectalExamination.ascx.cs"
    Inherits="HealthPackageControls_RectalExamination" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

//     function showContent(id) {
//         var chkvalue = id.split('_');

//         var trid = chkvalue[0] + "_tr1" + chkvalue[1] + "_" + chkvalue[2];
//         if (document.getElementById(id).checked == true) {
//             document.getElementById(trid).style.display = 'block';
//         }
//         else {
//             document.getElementById(trid).style.display = 'none';
//         }

     //     }

     function showContent(id, div) {
         if (document.getElementById('tcEMR_tpExamination_chk' + id).checked == true) {
             document.getElementById('tcEMR_tpExamination_tr' + div).style.display = 'block';
         }
         else {
             document.getElementById('tcEMR_tpExamination_tr' + div).style.display = 'none';
         }
     }
    
</script>
<div id="divRE1" onclick="showResponses('tcEMR_tpExamination_RectalExamination1_divRE1','tcEMR_tpExamination_RectalExamination1_divRE2','divRE3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Rectal Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divRE2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_RectalExamination1_divRE1','tcEMR_tpExamination_RectalExamination1_divRE2','divRE3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Rectal Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divRE3" style="display: none;width:100%" title="Rectal Examination">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblRectalExamination_911" runat="server" 
                Text="RECTAL EXAMINATION" meta:resourcekey="lblRectalExamination_911Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkRectum_912" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkRectum_912" runat="server" Text="Rectum" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkRectum_912Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkRectum_912" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_93" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_93Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_93" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_93_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_93Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR1" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_94" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_94" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_94Resource1"></asp:Label>
                                <asp:TextBox ID="txtAbnormal_440" runat="server" 
                                    meta:resourcekey="txtAbnormal_440Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_93" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkProstate_913" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkProstate_913" runat="server" Text="Prostate" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkProstate_913Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkProstate_913" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_95" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_95Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_95" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_95_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_95Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR2" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_96" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_96" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_96Resource1"></asp:Label>
                                <asp:TextBox ID="txtAbnormal_441" runat="server" 
                                    meta:resourcekey="txtAbnormal_441Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_95" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div> 