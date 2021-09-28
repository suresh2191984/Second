<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddNewInvestigation.ascx.cs"
    Inherits="CommonControls_AddNewInvestigation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript" language="javascript">
    function showPanel(textString) {
        if (textString == "shwInv") {
            document.getElementById('<%= pnlGrp.ClientID %>').style.display = 'none';
            document.getElementById('<%= pnlInv.ClientID%>').style.display = 'block';
        } else {
            document.getElementById('<%= pnlGrp.ClientID %>').style.display = 'block';
            document.getElementById('<%= pnlInv.ClientID%>').style.display = 'none';
        }
    }
    function splitInvID(source, args) {
        var invName = document.getElementById('<%= txtInvname.ClientID %>').value;
        var spliStr = invName.split('~');
        //alert(spliStr.length);
        if (spliStr.length >= 2) {
            document.getElementById('<%=hdnInvID.ClientID %>').value = spliStr[1];
            document.getElementById('<%= txtInvname.ClientID %>').value = spliStr[0];
            //alert(spliStr[1]);
        }
        else {
            document.getElementById('<%=hdnInvID.ClientID %>').value = '';
            //alert('New Investigation');
        }
    }
    function setValue() {
        document.getElementById('<%=hdnInvID.ClientID %>').value = '';
    }
    function splitGrpID(source, args) {

        var invName = document.getElementById('<%= txtGroupName.ClientID %>').value;
        var spliStr = invName.split('~');
        if (spliStr.length >= 2) {
            document.getElementById('<%= hdnInvID.ClientID %>').value = spliStr[1];
            document.getElementById('<%= txtGroupName.ClientID %>').value = spliStr[0];
            //alert(spliStr[1]);
        }
        else {

            document.getElementById('<%=hdnInvID.ClientID %>').value = '';
            //alert('New Investigation');
        }
    }

    function EmptyStringValidation() {
        if (document.getElementById('<%= pnlGrp.ClientID %>').style.display == 'block') {
            if (document.getElementById('<%= txtGroupName.ClientID %>').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\AddNewInvestigation.ascx.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter GroupName');
                }
                return false;
            }

        }

        if (document.getElementById('<%= pnlInv.ClientID %>').style.display == 'block') {
            if (document.getElementById('<%= txtInvname.ClientID %>').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\AddNewInvestigation.ascx.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter Investigation Name');
                }
                return false;
            }

        }
    }
</script>

<table>
    <tr id="trAdnew" runat="server" style="display:table-row">
        <td class="h-20 w-10p a-left" style="font-weight: normal;color: #000;">
            <input id="hdnInvID" runat="server" type="hidden" />
            <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click Here to add new investigation"
                ID="lnkAddnew" Text="Add New Investigation" OnClick="lnkAddnew_Click" meta:resourcekey="lnkAddnewResource1"></asp:LinkButton>
            <asp:Label ID="ltrMsg" runat="server" meta:resourcekey="ltrMsgResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
            <table class="w-70p">
                <tr>
                    <td>
                        <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                            meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                        <ajc:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                            PopupControlID="pnlAttrib" TargetControlID="hiddenTargetControlForModalPopup"
                            DynamicServicePath="" Enabled="True">
                        </ajc:ModalPopupExtender>
                        <asp:Panel ID="pnlAttrib" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                            runat="server" meta:resourcekey="pnlAttribResource1">
                            <table border="2" style="border-color: Red;">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rbList" RepeatDirection="Horizontal" runat="server" meta:resourcekey="rbListResource1">
                                            <asp:ListItem Selected="True" Value="1" Text="Investigation" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="Group" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <asp:Panel ID="pnlInv" Style="display: block;" runat="server" meta:resourcekey="pnlInvResource1">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblInvname" Text="Investigation Name" meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblHeader" runat="server" Text="Header" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblDept" runat="server" Text="Department" meta:resourcekey="lblDeptResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtInvname" runat="server" onblur="javascript:splitInvID('','');"
                                                            CssClass="small" meta:resourcekey="txtInvnameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtInvname"
                                                            ServiceMethod="getIndInvList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                            MinimumPrefixLength="2" CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                            Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlHeader" CssClass="ddlsmall" meta:resourcekey="ddlHeaderResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDept" CssClass="ddlsmall" meta:resourcekey="ddlDeptResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <asp:Panel Style="display: none;" ID="pnlGrp" runat="server" meta:resourcekey="pnlGrpResource1">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_EnterGroupName" runat="server" Text="Enter Group Name" meta:resourcekey="Rs_EnterGroupNameResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtGroupName" CssClass="small" runat="server" onblur="javascript:splitGrpID('','');"
                                                            meta:resourcekey="txtGroupNameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoGname" runat="server" TargetControlID="txtGroupName"
                                                            ServiceMethod="getgrpInvList" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                            MinimumPrefixLength="2" CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                            Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return EmptyStringValidation();"
                                                        OnClick="Save_Click" meta:resourcekey="btnSaveResource1" />
                                                </td>
                                                <td class="a-center">
                                                    <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        OnClick="btnCancel_Click" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label runat="server" ID="lblStatus" Visible="False" meta:resourcekey="lblStatusResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="imgProg" runat="server" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:UpdatePanel>--%>
        </td>
    </tr>
</table>
