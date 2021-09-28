<%@ Control Language="C#" AutoEventWireup="true" CodeFile="INVAttributes.ascx.cs"
    Inherits="InventoryCommon_Controls_INVAttributes" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>
<div>
</div>
<asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup w-50p hide" meta:resourcekey="Panel1Resource1">
    <div>
        <table class="w-100p">
            <tr>
                <td class="ackliteral a-right">
                    <asp:Literal ID="Literal1" runat="server" Visible="False" meta:resourcekey="Literal1Resource1"></asp:Literal>
                    <asp:Label ID="lblTest" runat="server" meta:resourcekey="lblTestResource1"></asp:Label>
                    <asp:Label ID="Rs_POReceivedQuantity" runat="server" Text="PO Received Quantity:"
                        meta:resourcekey="Rs_POReceivedQuantityResource1"></asp:Label>
                    <asp:Label ID="lblReceivedQty" runat="server" meta:resourcekey="lblReceivedQtyResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <div class="auto">
                        <asp:GridView ID="gvAttributes" runat="server" AutoGenerateColumns="False"
                            OnRowDataBound="gvAttributes_RowDataBound" CssClass="gridView w-75p"  meta:resourcekey="gvAttributesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Attribute" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnIsMandatory" runat="server" Value='<%# Eval("IsMandatory") %>' />
                                        <asp:Label ID="lblAttributes" runat="server" 
                                            Text='<%# Eval("AttributeName") %>' ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAttributeValues" runat="server" 
                                            Text='<%# Eval("AttributeValue") %>' 
                                            meta:resourcekey="txtAttributeValuesResource1"></asp:TextBox>
                                        <asp:Image Visible="False" ImageUrl="../PlatForm/Images/starbutton.png" ID="imgIsMandatory"
                                            runat="server" meta:resourcekey="imgIsMandatoryResource1" />
                                        <asp:HiddenField ID="hdnValues" runat="server" Value='<%# Eval("AttributeID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="a-center v-bottom">
                    <asp:Button ID="btnSave" runat="server" OnClientClick="return CheckAttributes();"
                        Text="Add" CssClass="btn w-60"
                        OnClick="BtnAdd_Click" meta:resourcekey="btnSaveResource1" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divNote" runat="server" class="a-right paddingR10 hide">
                        <asp:Label ID="Rs_NAUnAvailableField" runat="server" Text="Note : N/A UnAvailable Field"
                            meta:resourcekey="Rs_NAUnAvailableFieldResource1"></asp:Label>
                    </div>
                    <div class="auto h-250 w-500">
                        <asp:GridView ID="gvAttributeValues" runat="server"
                            OnRowCommand="gvAttributeValues_RowCommand" OnRowDataBound="gvAttributeValues_RowDataBound"
                            CssClass="gridView w-100p" meta:resourcekey="gvAttributeValuesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdn" runat="server" Value='<%# Eval("UnitNo") %>' />
                                        <asp:LinkButton CommandName="rDelete" CommandArgument='<%# Eval("UnitNo") %>' ID="lbtnDelete"
                                            runat="server" Text="Delete" meta:resourcekey="lbtnDeleteResource1"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="w-60" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </div>
                    <asp:Table ID="tabAttributes" runat="server" CssClass="w-50p"
                        meta:resourcekey="tabAttributesResource1">
                    </asp:Table>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button ID="btnOK" runat="server" Text="OK" CssClass="btn w-50" OnClick="btnOK_Click" OnClientClick="return showConfirm();"
                        meta:resourcekey="btnOKResource1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="cancel-btn w-50"
                        meta:resourcekey="btnCloseResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
<asd:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
    PopupControlID="Panel1" BackgroundCssClass="modalBackground" CancelControlID="btnClose"
    DynamicServicePath="" Enabled="True" />
<input type="button" id="btn" runat="server" class="hide" />
<asp:HiddenField ID="hdnMandatoryFields" runat="server" />
<asp:HiddenField ID="hdnAttValue" Value="N" runat="server" />
<asp:HiddenField ID="hdnGridCount" Value="0" runat="server" />
<asp:HiddenField ID="hdnTotalCount" Value="0" runat="server" />
<asp:HiddenField ID="hdnUsageLimit" Value="0" runat="server" />
<asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />

<script language="javascript" type="text/javascript">
    SetAttrib();
    function CheckAttributes() {
        var controls = document.getElementById('<%= hdnMandatoryFields.ClientID %>').value.split('~');
        for (i = 0; i < controls.length; i++) {
            if (controls[i] != "") {
                if (document.getElementById(controls[i]).value == "") {
                    var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_01') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_01') : "Enter the Values";
                    var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById(controls[i]).focus();
                    return false;
                }
            }
        }

        if (Number(document.getElementById('<%= hdnGridCount.ClientID %>').value) == Number(document.getElementById('<%= hdnTotalCount.ClientID %>').value)) {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_02') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_02') : "You Exceed The Product Quantity";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }

        return true;
    }

    function SetAttrib() {
        // alert('SetAttrib()');
        if (document.getElementById('<%= hdnAttValue.ClientID %>').value != "N") {
            document.getElementById('hdnAttributeDetail').value = document.getElementById('<%= hdnAttValue.ClientID %>').value;
            document.getElementById('<%= hdnAttValue.ClientID %>').value = "N";
            document.getElementById('hdnGridPopCount').value = document.getElementById('<%= hdnGridCount.ClientID %>').value;
        }
    }
    //    function ClearGrid() {
    //        var len = document.getElementById('<%=gvAttributes.ClientID %>').elements.length;
    //        for (var i = 0; i < len; i++) {
    //            if (document.getElementById('<%=gvAttributes.ClientID %>').elements[i].type == "Text") {
    //                document.getElementById('<%=gvAttributes.ClientID %>').elements[i].value = '';
    //            }
    //        }
    ////        var objGrid = document.getElementById('<%=gvAttributes.ClientID %>');
    ////        for (var i = 0; i < objGrid.length; i++) {
    ////            if (objGrid[i].type == 'text') {
    ////                objGrid[i].value = '';
    ////            }
    ////        }
    //        alert('Cleared!!!');
    //    }

    function showConfirm() {
        if (Number(document.getElementById('<%= hdnGridCount.ClientID %>').value) != Number(document.getElementById('<%= lblReceivedQty.ClientID %>').innerHTML)) {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_03') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVAttributes_ascx_03') : "Please Enter The Detail For Whole Quantity";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        return true;
    }
   
</script>

