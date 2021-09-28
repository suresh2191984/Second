<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicDHEBAdder.ascx.cs"
    Inherits="CommonControls_DynamicDHEBAdder" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="DHEBAutoCom" %>
<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">

    <script src="../Scripts/Un_DhebAdder.js" type="text/javascript" language="javascript"></script>

    <table class="tabletxt">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblItemName" runat="server" Text="Description" meta:resourcekey="lblItemNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtDescValue" CssClass="small" MaxLength="250" autocomplete="off"
                    meta:resourcekey="txtDescValueResource1"></asp:TextBox>
                &nbsp;&nbsp;
                <DHEBAutoCom:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtDescValue"
                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" DelimiterCharacters=""
                    Enabled="True" ServicePath="">
                </DHEBAutoCom:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblCommentName" runat="server" Text="Comments" meta:resourcekey="lblCommentNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtComments" runat="server" MaxLength="250" autocomplete="off" CssClass="small"
                    meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                &nbsp;<input id="newDHEB" class="btn" onclick="return AddDHEB('<%= txtDescValue.ClientID %>','<%= txtComments.ClientID %>',
                    '<%= hdnValuesDeleted.ClientID %>','<%= dvTable.ClientID %>',
                    '<%= hdfValues.ClientID %>','<%= hdnValueExists.ClientID %>',
                    '<%= DescriptionDisplayText %>','<%= CommentDisplayText %>');" tooltip="Add New"
                    type="button" value="Add" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="a-center" colspan="2">
                <div id="dvTable" runat="server">
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" id="did" runat="server" />
</asp:Panel>
<asp:HiddenField ID="hdfValues" runat="server" />
<asp:HiddenField ID="hdnValueExists" runat="server" />
<asp:HiddenField ID="hdnValuesDeleted" runat="server" />
