<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvSampleControl.ascx.cs"
    Inherits="CommonControls_InvSampleControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="AddNewInvestigation.ascx" TagName="AddInvestigation" TagPrefix="AddnewInv" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
<%--<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>--%>
<asp:HiddenField ID="iconHid" runat="server" />
<input type="hidden" id="HdnLPF" value="" runat="server" />
<input type="hidden" id="hidID" value="" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td valign="top">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblGroup" runat="server" Font-Bold="True" Visible="False" 
                            Text="Group" meta:resourcekey="lblGroupResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--  <td style="display:none" nowrap="nowrap">
                                
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtGroup" Visible="false" Width="150px" runat="server" autocomplete="off"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname" runat="server" TargetControlID="txtGroup"
                                            ServiceMethod="getgrpInvList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                            MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp1" CompletionInterval="10"
                                            DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:Button ID="btnAdd" Visible="false" runat="server" Text="Add" CssClass="btn"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnAdd_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>--%>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBoxList ID="listGRP" Visible="False" runat="server" RepeatColumns="5" 
                            CellSpacing="5" meta:resourcekey="listGRPResource1">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPackage" runat="server" Visible="False" Text="Package" 
                            meta:resourcekey="lblPackageResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listPKG" Style="display: none;" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="350px" onclick="javascript:return SetId(this.id);" Height="100px" 
                            meta:resourcekey="listPKGResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLCON" runat="server" Visible="False" Text="Consumables" 
                            meta:resourcekey="lblLCONResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listLCON" Visible="False" runat="server" ToolTip="Double Click the List or Press Enter to Select Consumables"
                            onfocus="javascript:deselectLists(this.id);" Width="350px" Height="100px" 
                            onclick="javascript:return SetId(this.id);" 
                            meta:resourcekey="listLCONResource1">
                        </asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblBloodBank" runat="server" Visible="False" Text="Blood Bank" 
                            meta:resourcekey="lblBloodBankResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="listBLB" Style="display: none;" runat="server" onfocus="javascript:deselectLists(this.id);"
                            Width="350px" Height="100px" onclick="javascript:return SetId(this.id);" 
                            meta:resourcekey="listBLBResource1"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Label ID="lblInvestigation" Font-Bold="True" runat="server" Visible="False"
                            Text="Investigation" meta:resourcekey="lblInvestigationResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="display: none" align="left">
                        <asp:UpdatePanel ID="up2" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtINV" Visible="False" Width="150px" runat="server" 
                                    autocomplete="off" meta:resourcekey="txtINVResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtINV"
                                    ServiceMethod="getIndInvList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                    Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;
                                <asp:Button ID="btnInvAdd" Visible="False" runat="server" Text="Add" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" 
                                    onmouseout="this.className='btn'" OnClick="btnInvAdd_Click" 
                                    meta:resourcekey="btnInvAddResource1" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr style="display: none;">
                                <td>
                                    <asp:Label ID="lblSearchInves" runat="server" Text="Investigation search" 
                                        meta:resourcekey="lblSearchInvesResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtsearch" runat="server" 
                                        OnTextChanged="txtsearch_TextChanged" meta:resourcekey="txtsearchResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnsearch" Text="search" runat="server" 
                                        OnClick="btnsearch_Click" meta:resourcekey="btnsearchResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:CheckBoxList ID="listINV" Visible="False" runat="server" RepeatColumns="5" 
                                        CellSpacing="5" meta:resourcekey="listINVResource1">
                                    </asp:CheckBoxList>
                                    <%--<ajc:ListSearchExtender ID="ListSearchExtender1" PromptPosition="Bottom" QueryPattern="StartsWith"
                                                runat="server" TargetControlID="listINV" PromptCssClass="ListSearchExtenderPrompt"
                                                IsSorted="false">
                                            </ajc:ListSearchExtender>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top">
            <br />
            <br />
            <table id="Table1" cellpadding="0px" cellspacing="0" width="96%">
                <tr>
                    <td>
                        <asp:Label ID="lblHeader" runat="server" Text="Ordered Investigations" Style="display: none;
                            font-size: 12px; vertical-align: middle; padding: 5px;" 
                            CssClass="Duecolor" meta:resourcekey="lblHeaderResource1"></asp:Label>
                    </td>
                </tr>
            </table>
            <table id="tblOrederedInves" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                width="96%">
            </table>
            <table width="96%" id="tblTot" style="display: none" class="dataheaderInvCtrl">
                <tr>
                    <td align="right" style="width: 60%">
                        <asp:Label ID="lblTotaltxt" runat="server" Text="Total Amount :" 
                            meta:resourcekey="lblTotaltxtResource1"></asp:Label>
                    </td>
                    <td align="right" style="width: 36%">
                        <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="ISAddItems" runat="server" />
<%--<asp:HiddenField ID="hdnGRPINV" runat="server" />--%>
<asp:HiddenField ID="hdnFromDate" Value='<%= DateTime.Now %>' runat="server" />
<%-- </ContentTemplate>
</asp:UpdatePanel>--%>
<%--
<script language="javascript" type="text/javascript">
    //LoadOrdItems();
    if (document.getElementById('<%= hidID.ClientID %>') != null && document.getElementById('<%=listINV.ClientID %>') != null) {
        document.getElementById('<%= hidID.ClientID %>').value = document.getElementById('<%=listINV.ClientID %>').id;
        document.getElementById('<%=listINV.ClientID %>').selectedIndex = 0;
        SetId(document.getElementById('<%= hidID.ClientID %>').value);
    }
</script>--%>