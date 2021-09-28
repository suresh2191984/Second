<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MenuItemList.ascx.cs"
    Inherits="CommonControls_MenuItemList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>
<asp:HiddenField ID="hdnOrgID" runat="server" />
<asp:HiddenField ID="hdnRoleID" runat="server" />
<asp:HiddenField ID="hdnReports" runat="server" />
<asp:HiddenField ID="hdnRept" runat="server" />
<asp:Repeater ID="rptUCHolder" runat="server" OnItemDataBound="rptUCHolder_ItemDataBound">
    <ItemTemplate>
        <asp:HiddenField ID="hdnParentID" runat="server" 
            Value='<%# Eval("ParentID") %>' />
        <asp:Panel ID="pnlMenu" Font-Bold="True" runat="server" Width="660px" 
            meta:resourcekey="pnlMenuResource1">
            <asp:CheckBoxList ID="chkMenu" runat="server" RepeatColumns="3" CellSpacing="5" 
                meta:resourcekey="chkMenuResource1">
            </asp:CheckBoxList>
        </asp:Panel>
        <br />
    </ItemTemplate>
</asp:Repeater>
<asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
<asp:Button ID="ButtonEdit" Style="display: none" runat="server" Text="Edit" 
    meta:resourcekey="ButtonEditResource1" />
<asd:ModalPopupExtender ID="ModalPopupExtender" runat="server" CancelControlID="btnCancel"
    TargetControlID="ButtonEdit" PopupControlID="DivEditWindow" BackgroundCssClass="modalBackground"
    BehaviorID="EditModalPopup" DynamicServicePath="" Enabled="True">
</asd:ModalPopupExtender>
<div id="DivEditWindow" style="overflow: scroll; border: 5px; background-color: White;
    border-color: #fff; height: 450px; width: 700px; display: none;" class="ancCSviolet"">
    <table>
        <tr>
            <td>
            </td>
            <td>
                <asp:Repeater ID="RptrReports" runat="server" OnItemDataBound="RptrReports_ItemDataBound">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnGroupID" runat="server" 
                            Value='<%# Eval("ReportGroupID") %>' />
                        <asp:Panel ID="pnlMenu1" Font-Bold="True" runat="server" Width="650px" 
                            meta:resourcekey="pnlMenu1Resource1">
                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="Select All" 
                                meta:resourcekey="chkSelectAllResource1" />
                            <asp:CheckBoxList ID="chkReports" runat="server" RepeatColumns="3" 
                                CellSpacing="5" meta:resourcekey="chkReportsResource1">
                            </asp:CheckBoxList>
                        </asp:Panel>
                        <br />
                    </ItemTemplate>
                </asp:Repeater>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" 
                    meta:resourcekey="btnSaveResource1" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="btnCancelResource1" />
            </td>
        </tr>
    </table>
</div>

<script language="javascript" type="text/javascript">
    function ShowEditModal(val, obj) {
        var ExpanseID = val;
        $find('EditModalPopup').show();
    }
    function checkreports() {

        var objNoRecord = SListForAppMsg.Get("CommonControls_MenuItemList_ascx_01") == null ? "No Reports Found" : SListForAppMsg.Get("CommonControls_MenuItemList_ascx_01");
        var objAlert = SListForAppMsg.Get("CommonControls_MenuItemList_ascx_Alert") == null ? "Alert" : SListForAppMsg.Get("CommonControls_MenuItemList_ascx_Alert");

        var userMsg = SListForApplicationMessages.Get('CommonControls\\MenuItemList.ascx_1');
        if (userMsg != null) {
            //            alert(userMsg);
            ValidationWindow(userMsg, objAlert);

        } else {
        //alert('No Reports Found');
        ValidationWindow(objNoRecord, objAlert);

        }
        return false;
    }
    function chkAll(obj1) {
        var obj = obj1.split('|')[1];
        var newObj1 = obj1.split('|')[0].split('^')[obj - 1];
        var strLen = newObj1.split('~').length;
        var str = newObj1.split('~');
        var len = document.forms[0].elements.length;
        var isChecked = false;

        for (var i = 0; i < len; i++) {
            var sd = 0;
            if (document.forms[0].elements[i].id.split('_')[3] == "chkSelectAll") {
                if (document.forms[0].elements[i + sd].checked == true) {
                    isChecked = true;
                }
                if (document.forms[0].elements[i + sd].checked == false) {
                    isChecked = false;
                    sd = sd + 1;
                }
            }
            if ((document.forms[0].elements[i].id.split('_')[3] == "chkReports") && (document.forms[0].elements[i].type.toString().toLowerCase() == "checkbox")) {
                for (var j = 0; j < strLen - 1; j++) {
                    if (document.forms[0].elements[i].nextSibling.outerText.trim() == str[j]) {
                        document.forms[0].elements[i].checked = isChecked;
                    }
                }
            }
        }
    }
</script>

