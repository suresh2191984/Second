<%@ Control Language="C#" AutoEventWireup="true" CodeFile="INVAttributeUsage.ascx.cs"
    Inherits="CommonControls_INVAttributeUsage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>
<div>
</div>
<asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Width="50%"
    Style="display: none" meta:resourcekey="Panel1Resource1">
    <div>
        <table width="100%">
            <tr>
                <td align="center">
                    <table>
                        <tr>
                            <td class="ackliteral" align="left" style="width: 50%">
                                <asp:Literal ID="Literal1" runat="server" Visible="False" meta:resourcekey="Literal1Resource1"></asp:Literal>
                                <asp:Label ID="lblTest" runat="server" meta:resourcekey="lblTestResource1"></asp:Label>
                            </td>
                            <td class="tdRcvdQty" align="right" style="width: 50%">
                                <asp:Label ID="Rs_ProductQuantity" runat="server" Text="Product Quantity:" meta:resourcekey="Rs_ProductQuantityResource1"></asp:Label>
                                <asp:Label ID="lblReceivedQty" runat="server" meta:resourcekey="lblReceivedQtyResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="overflow: auto;">
                        <asp:GridView ID="gvAttributes" CellSpacing="2" CellPadding="2" runat="server" AutoGenerateColumns="False"
                            OnRowDataBound="gvAttributes_RowDataBound" CssClass="mytable1" Width="75%" meta:resourcekey="gvAttributesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Attribute" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnIsMandatory" runat="server" Value='<%# Eval("IsMandatory") %>' />
                                        <asp:Label ID="lblAttributes" runat="server" Text='<%# Eval("AttributeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAttributeValues" runat="server" Text='<%# Eval("AttributeValue") %>'></asp:TextBox>
                                        <asp:Image Visible="False" ImageUrl="../Images/starbutton.png" ID="imgIsMandatory"
                                            runat="server" />
                                        <asp:HiddenField ID="hdnValues" runat="server" Value='<%# Eval("AttributeID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="dataheader1" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" valign="bottom">
                    <asp:Button ID="btnSave" runat="server" OnClientClick="javascript:return CheckAttributes();"
                        Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClick="BtnAdd_Click" Width="60px" meta:resourcekey="btnSaveResource1" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="overflow: auto; height: 250px; width: 500px;">
                        <asp:GridView ID="gvAttributeValues" CellSpacing="2" CellPadding="2" runat="server"
                            OnRowCommand="gvAttributeValues_RowCommand" OnRowDataBound="gvAttributeValues_RowDataBound"
                            CssClass="mytable1" Width="100%" meta:resourcekey="gvAttributeValuesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdn" runat="server" Value='<%# Eval("UnitNo") %>' />
                                        <asp:LinkButton CommandName="rDelete" CommandArgument='<%# Eval("UnitNo") %>' ID="lbtnDelete"
                                            runat="server" Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="60px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="dataheader1" />
                        </asp:GridView>
                    </div>
                    <asp:Table ID="tabAttributes" CellPadding="2" CellSpacing="2" runat="server" Width="50%"
                        meta:resourcekey="tabAttributesResource1">
                    </asp:Table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnOK" runat="server" Width="50px" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" OnClick="btnOK_Click" OnClientClick="javascript:return CheckDetailsAttrip()"
                        meta:resourcekey="btnOKResource1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnClose" runat="server" Width="50px" Text="Close" CssClass="btn"
                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnClose_Click"
                        meta:resourcekey="btnCloseResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
<asd:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
    PopupControlID="Panel1" BackgroundCssClass="modalBackground" DynamicServicePath=""
    Enabled="True" />
<input type="button" id="btn" runat="server" style="display: none;" />
<asp:HiddenField ID="hdnMandatoryFields" runat="server" />
<asp:HiddenField ID="hdnAttValue" Value="N" runat="server" />
<asp:HiddenField ID="hdnActionFlag" runat="server" />
<asp:HiddenField ID="hdnQty" Value="0" runat="server" />
<asp:HiddenField ID="hdnRcvdQty" runat="server" />
<asp:HiddenField ID="hdnExAttrip" runat="server" />

<script language="javascript" type="text/javascript">
function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_1") 
            {
            alert('Product quantity has been exceeded');
            }
           else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_2") 
            {
            alert('Cannot be added multiple times');
            }
             else if (key == "CommonControls\\INVAttributeUsage.ascx.cs_3") 
            {
            alert('Product Detail Does not Exist');
            }
           return true;
        }
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
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\INVAttributeUsage.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else { alert("Enter the Values"); }
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
                document.getElementById('InvStockUsage1_trAttribute').style.display = "block";
                document.getElementById('InvStockUsage1_txtBatchQuantity').value = document.getElementById('InvStockUsage1_hdnTotalqty').value;
            }
        }
        document.getElementById('InvStockUsage1_hdnAttributeDetailTmp').value = document.getElementById('<%= hdnExAttrip.ClientID %>').value;

        document.getElementById('add').value = document.getElementById('<%= hdnActionFlag.ClientID %>').value;

    }

    function CheckDetailsAttrip() {
        var x;

        if (Number(document.getElementById('<%= hdnRcvdQty.ClientID %>').value) > Number(document.getElementById('<%= hdnQty.ClientID %>').value) && Number(document.getElementById('<%= hdnQty.ClientID %>').value) != 0) {
            x = confirm('Do You Want Continue With Partial Updation');
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

