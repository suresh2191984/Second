<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GynaecologicalExam.ascx.cs"
    Inherits="HealthPackageControls_GynaecologicalExam" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

//    function showContent(id) {
//        var chkvalue = id.split('_');

//        var trid = chkvalue[0] + "_tr1" + chkvalue[1] + "_" + chkvalue[2];
//        if (document.getElementById(id).checked == true) {
//            document.getElementById(trid).style.display = 'block';
//        }
//        else {
//            document.getElementById(trid).style.display = 'none';
//        }

//    }
    
</script>

<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblGynaecologicalExamination_907" runat="server" 
                Text="GYNAECOLOGICAL EXAMINATION" 
                meta:resourcekey="lblGynaecologicalExamination_907Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkBreasts_908" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkBreasts_908" runat="server" Text="Breasts" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkBreasts_908Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkBreasts_908" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_87" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_87Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_87" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_87_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_87Resource1" CssClass="ddlsmall">
                                    <asp:ListItem Text="Normal" Value="387" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Abnormal" Value="388" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td id="trAbnormalities_88" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_88" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_88Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_88" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_88_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_88Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                                <td id="divddlAbnormalities_88" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_405" runat="server" 
                                        meta:resourcekey="txtOthers_405Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_87" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkUterus_909" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkUterus_909" runat="server" Text="Uterus" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkUterus_909Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkUterus_909" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_89" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_89Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_89" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_89_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_89Resource1" CssClass="ddlsmall">
                                    <asp:ListItem Text="Normal" Value="406" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                    <asp:ListItem Text="Abnormal" Value="407" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td id="trAbnormalities_90" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_90" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_90Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_90" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_90_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_90Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                                <td id="divddlAbnormalities_90" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_415" runat="server" 
                                        meta:resourcekey="txtOthers_415Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_89" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkExternalGenetaila_910" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkExternalGenetaila_910" runat="server" Text="External Genetaila"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkExternalGenetaila_910Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkExternalGenetaila_910" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_91" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_91Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_91" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_91_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_91Resource1" CssClass="ddlsmall">
                                    <asp:ListItem Text="Normal" Value="395" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                    <asp:ListItem Text="Abnormal" Value="396" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td id="trAbnormalities_92" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_92" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_92Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_92" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_92_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_92Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                                <td id="divddlAbnormalities_92" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_394" runat="server" 
                                        meta:resourcekey="txtOthers_394Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_91" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
