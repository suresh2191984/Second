<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SymptomaticOrAsymptomatic.ascx.cs"
    Inherits="CommonControls_SymptomaticOrAsymptomatic" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trSymptomatic" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblSymptomatic_1113" runat="server" Text="Symptomatic" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1113" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1113" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <%--<asp:RadioButton ID="rdoUnknown_1113" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />--%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1113" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr valign="bottom" align="center">
                        <td colspan="3" valign="bottom" align="left">
                            <asp:TextBox ID="txtSymptomaticOrAsymptomatic" runat="server"></asp:TextBox>
                            <cc1:AutoCompleteExtender ID="AutoSymptoms" runat="server" TargetControlID="txtSymptomaticOrAsymptomatic"
                                FirstRowSelected="True" ServiceMethod="GetSymptoms" ServicePath="~/WebService.asmx"
                                EnableCaching="False" MinimumPrefixLength="1" BehaviorID="AutoCompleteEx1" CompletionInterval="500"
                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>

<script type="text/javascript">
</script>

