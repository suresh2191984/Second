<%@ Control Language="C#" AutoEventWireup="true" CodeFile="INVAttributeUsage.ascx.cs"
    Inherits="InventoryCommon_Controls_INVAttributeUsage" %>

<asp:Panel ID="Panel1" runat="server"
    CssClass="hide w-50p" meta:resourcekey="Panel1Resource1">
    <div>
        <table class="w-100p">
            <tr>
                <td class="a-center">
                    <table>
                        <tr>
                            <td>
                                <asp:Literal ID="Literal1" runat="server" Visible="False" meta:resourcekey="Literal1Resource1"></asp:Literal>
                                <asp:Label ID="lblTest" runat="server" meta:resourcekey="lblTestResource1"></asp:Label>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Rs_ProductQuantity" runat="server" Text="Product Quantity:" meta:resourcekey="Rs_ProductQuantityResource1"></asp:Label>
                                <asp:Label ID="lblReceivedQty" runat="server" meta:resourcekey="lblReceivedQtyResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <div class="auto">
                        <asp:GridView ID="gvAttributes" runat="server" AutoGenerateColumns="False"
                            OnRowDataBound="gvAttributes_RowDataBound" CssClass="gridView w-100p" meta:resourcekey="gvAttributesResource1">
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
                                            ></asp:TextBox>
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
                <td class="a-center">
                    <asp:Button ID="btnSave" runat="server" OnClientClick="javascript:return CheckAttributes();"
                        Text="Add" CssClass="btn"
                        OnClick="BtnAdd_Click" Width="60px" meta:resourcekey="btnSaveResource1" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <div >
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
                                    <ItemStyle Width="60px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </div>
                    <asp:Table ID="tabAttributes" runat="server" CssClass="w-100p"
                        meta:resourcekey="tabAttributesResource1">
                    </asp:Table>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button ID="btnOK" runat="server" Width="50px" Text="OK" CssClass="btn" OnClick="btnOK_Click" OnClientClick="javascript:return CheckDetailsAttrip()"
                        meta:resourcekey="btnOKResource1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="cancel-btn"
                        OnClick="btnClose_Click"
                        meta:resourcekey="btnCloseResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
<ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
    PopupControlID="Panel1" BackgroundCssClass="modalBackground" DynamicServicePath=""
    Enabled="True" />
<input type="button" id="btn" runat="server" class="hide" />
<asp:HiddenField ID="hdnMandatoryFields" runat="server" />
<asp:HiddenField ID="hdnAttValue" Value="N" runat="server" />
<asp:HiddenField ID="hdnActionFlag" runat="server" />
<asp:HiddenField ID="hdnQty" Value="0" runat="server" />
<asp:HiddenField ID="hdnRcvdQty" runat="server" />
<asp:HiddenField ID="hdnExAttrip" runat="server" />
<asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />

<script language="javascript" type="text/javascript">
//function ShowAlertMsg(key) {
//       var userMsg = SListForApplicationMessages.Get(key);
//            if (userMsg != null) {
//                alert(userMsg);
//            }
//            else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_1") 
//            {
//            alert('Product quantity has been exceeded');
//            }
//           else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_2") 
//            {
//            alert('Cannot be added multiple times');
//            }
//             else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_3") 
//            {
//            alert('Product Detail Does not Exist');
//            }
//           return true;
//        }
    SetAttrib();
    function CheckAttributes() {
        //        var grid = document.getElementById('<%= gvAttributes.ClientID %>');
        //        var Inputs = grid.getElementsByTagName("input");
        //        var IsMandatory = 'N';
        //        for (i = 0; i < Inputs.length; i++) {
        //            if ((Inputs[i].type == 'hidden')) {
        //                if (Inputs[i].value == 'Y') {
        //                    IsMandatory = 'Y';
        //                }
        //            }
        //            if ((Inputs[i].type == 'text')) {
        //                if (IsMandatory == 'Y') {
        //                    if (Inputs[i].value == '') {
        //                        alert("Enter the Values");
        //                        IsMandatory = 'N';
        //                        Inputs[i].focus();
        //                        return false;

        //                    }
        //                }
        //            }
        //        }
        //        return true;
        //        if (Number(document.getElementById('<%= hdnRcvdQty.ClientID %>').value) < Number(document.getElementById('<%= hdnQty.ClientID %>').value)) {
        //           alert('You Are About Exceeding The Usage Quantity');
        //            return false;
        //        }


        var controls = document.getElementById('<%= hdnMandatoryFields.ClientID %>').value.split('~');
        for (i = 0; i < controls.length; i++) {
            if (controls[i] != "") {
                if (document.getElementById(controls[i]).value == "") {
                    var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVAttributeUsage_ascx_04') != null ? SListForAppMsg.Get('InventoryCommon_Controls_INVAttributeUsage_ascx_04') : "Enter the Values";
                    var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById(controls[i]).focus();
                    return false;
                }
            }
        } return true;
    }

    function SetAttrib() {
        // alert('SetAttrib()');
        if (document.getElementById('<%= hdnAttValue.ClientID %>').value != "N") {
            document.getElementById('InvStockUsage1_hdnAttributeDetail').value = document.getElementById('<%= hdnAttValue.ClientID %>').value;
            document.getElementById('<%= hdnAttValue.ClientID %>').value = "N";
        }
        if (document.getElementById('InvStockUsage1_hdnTotalqty') != null) {
            if (document.getElementById('InvStockUsage1_hdnTotalqty').value != "") {
                //document.getElementById('InvStockUsage1_trAttribute').style.display = "block";
                $('#InvStockUsage1_trAttribute').removeClass().addClass('show');
                document.getElementById('InvStockUsage1_txtBatchQuantity').value = document.getElementById('InvStockUsage1_hdnTotalqty').value;
            }
        }
        document.getElementById('InvStockUsage1_hdnAttributeDetailTmp').value = document.getElementById('<%= hdnExAttrip.ClientID %>').value;

        document.getElementById('add').value = document.getElementById('<%= hdnActionFlag.ClientID %>').value;

    }

    function CheckDetailsAttrip() {
        var x;

        if (Number(document.getElementById('<%= hdnRcvdQty.ClientID %>').value) > Number(document.getElementById('<%= hdnQty.ClientID %>').value) && Number(document.getElementById('<%= hdnQty.ClientID %>').value) != 0) {

            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_INVAttributeUsage_ascx_05');
            if (userMsg == null) {
                userMsg = 'Do You Want Continue With Partial Updation';
            }
            var Confirm = SListForAppMsg.Get('InventoryCommon_Information');
            if (Confirm == null) {
                Confirm = 'Information';
            }
            var OkMsg = SListForAppMsg.Get('InventoryCommon_OK');
            if (OkMsg == null) {
                OkMsg = 'Ok';
            }
            var CancelMsg = SListForAppMsg.Get('InventoryCommon_Cancel');
            if (CancelMsg == null) {
                CancelMsg = 'Cancel';
            }
            

            x = ConfirmWindow(userMsg, Confirm, OkMsg, CancelMsg);
            if (x == true) {
                document.getElementById('InvStockUsage1_txtQuantity').value = Number(document.getElementById('<%= hdnRcvdQty.ClientID %>').value) - Number(document.getElementById('<%= hdnQty.ClientID %>').value);
                document.getElementById('InvStockUsage1_hdnQuantity').value = Number(document.getElementById('<%= hdnRcvdQty.ClientID %>').value) - Number(document.getElementById('<%= hdnQty.ClientID %>').value);
                return true;
            }
            else {

                return false;
            }
        }

    }
   
</script>

