<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CardiacDiseases.ascx.cs"
    Inherits="CommonControls_CardiacDiseases" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trrdoYes_332" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblHeartDisease_332" runat="server" Text="Cardiac Diseases" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_332" Text="Yes" runat="server" GroupName="radioExtendC"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_332" Text="No" runat="server" GroupName="radioExtendC"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_332" Text="Unknown" runat="server" GroupName="radioExtendC"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_332" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblDiseaseType_3" runat="server" Text="Disease Type" meta:resourcekey="lblDiseaseType_3Resource1"></asp:Label>
                        </td>
                        <td></td>
                        <td>
                            <asp:Label ID="lblDisease_4" runat="server" Text="Disease" meta:resourcekey="lblDisease_4Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <asp:DropDownList ID="ddlDiseaseType_3" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                meta:resourcekey="ddlDiseaseType_3Resource1">
                            </asp:DropDownList>
                            </td>
                            <td>
                            <div id="divddlDiseaseType_3" runat="server" style="display: none">
                                <asp:TextBox ID="txtothers_16" runat="server" meta:resourcekey="txtothers_16Resource1"></asp:TextBox>
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDisease_17" runat="server"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtDisease_17"
                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
