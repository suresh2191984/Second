<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionIngredients.ascx.cs"
    Inherits="CommonControls_NutritionIngredients" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder"
    align="center">
    <tr>
        <td>
            <div class="contentdata1">
                <asp:UpdatePanel ID="updatePanel4" runat="server">
                    <ContentTemplate>
                        <table class="dataheader2 defaultfontcolor" width="100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFoodIngredientName" runat="server" Text="Food Ingredient Name"
                                                    meta:resourcekey="lblFoodIngredientNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFoodIngredientName" MaxLength="150" CssClass="Txtboxsmall" runat="server"
                                                    meta:resourcekey="txtFoodIngredientNameResource1"></asp:TextBox>
                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionResource1"
                                                    Text="Description"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" meta:resourcekey="txtDescriptionResource1"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="Ingredient" runat="server" CssClass="btn" meta:resourcekey="IngredientResource1"
                                                    OnClick="Ingredient_Click" OnClientClick="return ValidationDiet_Ing()" Text="Save"
                                                    ToolTip="Click here to Save" />
                                                <asp:Button ID="btnIngredientCancel" runat="server" CssClass="btn" meta:resourcekey="btnIngredientCancelResource1"
                                                    OnClientClick="document.location.reload(true)" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" TabIndex="4" Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="HdnIngredientSave" runat="server" />
                        <table id="Table2" class="dataheader2 defaultfontcolor" width="100%">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvIng" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="1" CellSpacing="1" CssClass="mytable1" ForeColor="#333333" meta:resourcekey="gvIngResource1"
                                        OnPageIndexChanging="gvIng_PageIndexChanging" OnRowDataBound="gvIng_RowDataBound"
                                        Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdSel2" runat="server" GroupName="OrderSelect" meta:resourcekey="rdSel2Resource1"
                                                        ToolTip="Select Row" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodIngredientID" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodIngredientID" runat="server" meta:resourcekey="lblFoodIngredientIDResource1"
                                                        Text='<%# Eval("FoodIngredientID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodIngredientName" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodIngredientName" runat="server" meta:resourcekey="lblFoodIngredientNameResource2"
                                                        Text='<%# Eval("FoodIngredientName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource4">
                                                <ItemStyle HorizontalAlign="Left" Width="30%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionResource2"
                                                        Text='<%# Eval("Description") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                        <RowStyle HorizontalAlign="Left" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        </input>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdningID" runat="server" Value="0" />

<script type="text/javascript">
    function extractRowIngredient(SeClientID, ingID, FoodIngredientName, Disp) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(SeClientID).checked = true;
        document.getElementById('<%=hdningID.ClientID %>').value = ingID;
        document.getElementById('<%=txtFoodIngredientName.ClientID %>').value = FoodIngredientName;
        document.getElementById('<%=txtDescription.ClientID %>').value = Disp;
        document.getElementById('<%=Ingredient.ClientID %>').value = "Update";
        document.getElementById('<%=HdnIngredientSave.ClientID %>').value = "Update";

    }
    function ValidationDiet_Ing() {

        if (document.getElementById('<%=txtFoodIngredientName.ClientID %>').value.trim() == '') {
            var userMsg = SListForApplicationMessages.Get("CommonControls\\NutritionIngredients.ascx_1");
            if (userMsg != 'undefined') {
                alert(userMsg);
                document.getElementById('<%=txtFoodIngredientName.ClientID %>').focus();
                return false;

            }
            else {
                alert('Provide Ingredient Name');
                document.getElementById('<%=txtFoodIngredientName.ClientID %>').focus();
                return false;

            }
        }
    } 
</script>

