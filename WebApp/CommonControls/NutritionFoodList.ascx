<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionFoodList.ascx.cs"
    Inherits="CommonControls_NutritionFoodList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .searchBox
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 15px;
        width: 162px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        margin-left: 0px;
        background-image: url('../Images/magnifying-glass.png');
        background-repeat: no-repeat;
        padding-left: 20px;
    }
</style>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder"
    align="center">
    <tr>
        <td>
            <div class="contentdata1">
                <asp:UpdatePanel ID="updatePanel5" runat="server">
                    <ContentTemplate>
                        <table class="dataheader2 defaultfontcolor" width="100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFoodName" runat="server" Text="Food Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFoodName" MaxLength="150" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFoodCategoryID" runat="server" Text="Food CategoryName"></asp:Label>
                                            </td>
                                            <td class="style5">
                                                <asp:TextBox ID="txtFoodCatoName" runat="server" CssClass="searchBox" MaxLength="255"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain .box mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                    CompletionListItemCssClass="wordWheel itemsMain mediumList" DelimiterCharacters=""
                                                    EnableCaching="False" Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1"
                                                    OnClientItemSelected="doOnSelectFoodCategoryName" ServiceMethod="GetFoodCategory"
                                                    ServicePath="~/NutritionWebService.asmx" TargetControlID="txtFoodCatoName" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnFoodCategoryID" runat="server" />
                                            </td>
                                            <td class="style3">
                                                <asp:Label ID="LabelDecription" runat="server" Text="Description"></asp:Label>
                                            </td>
                                            <td class="style3">
                                                <asp:TextBox ID="txtFoodlistDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                            <td class="style3">
                                                <asp:Button ID="btnSaveFoodList" runat="server" CssClass="btn" OnClick="btnSaveFoodList_Click"
                                                    OnClientClick="return ValidationDiet_FoodList()" Text="Save" ToolTip="Click here to Save" />
                                                <asp:Button ID="btnFListCancel" runat="server" CssClass="btn" OnClientClick="document.location.reload(true)"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" TabIndex="4"
                                                    Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="hdnSaveFoodList" runat="server" />
                        <table class="dataheader2 defaultfontcolor" width="100%" id="Table3">
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="gvFoodList" Width="100%" runat="server" AllowPaging="True" CellSpacing="1"
                                        CellPadding="1" AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1"
                                        OnPageIndexChanging="gvFoodList_PageIndexChanging" OnRowDataBound="gvFoodList_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdSel3" runat="server" ToolTip="Select Row" GroupName="OrderSelect" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodListID" Visible="false">
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodListID" runat="server" Text='<%# Eval("FoodID")   %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodCategoryName">
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodCategoryName" runat="server" Text='<%# Eval("FoodCategoryName")   %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodListName">
                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodListName" runat="server" Text='<%# Eval("FoodName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description">
                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllistDesc" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle HorizontalAlign="Left" />
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="dataheader1" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnFoodListID" runat="server" Value="0" />

<script type="text/javascript">
    //------------------------------------------NRRAJAN-------------------------------------------


    function extractRowFoodList(SeClientIDFL, ingIDs, DFoodCategoryName, FoodIngredientName, Disps, CategoryID) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(SeClientIDFL).checked = true;
        document.getElementById('<%=hdnFoodListID.ClientID %>').value = ingIDs;
        document.getElementById('<%=txtFoodCatoName.ClientID %>').value = DFoodCategoryName;
        document.getElementById('<%=hdnFoodCategoryID.ClientID %>').value = CategoryID;
        document.getElementById('<%=txtFoodName.ClientID %>').value = FoodIngredientName;
        document.getElementById('<%=txtFoodlistDescription.ClientID %>').value = Disps;
        document.getElementById('<%=btnSaveFoodList.ClientID %>').value = "Update";
        document.getElementById('<%=hdnSaveFoodList.ClientID %>').value = "Update";
        $('#<%=txtFoodCatoName.ClientID %>').attr('disabled', true);
    }


    function ValidationDiet_FoodList() {

        if (document.getElementById('<%=txtFoodName.ClientID %>').value.trim() == '') {
            var userMsg = SListForApplicationMessages.Get("CommonControls\\NutritionFoodList.ascx_1");
            if (userMsg != null) {
                alert(userMsg);
                document.getElementById('<%=txtFoodName.ClientID %>').focus();
                return false;
            } else {
                alert('Provide  FoodList Name');
                document.getElementById('<%=txtFoodName.ClientID %>').focus();
                return false;
            }
        }
    }
    function doOnSelectFoodCategoryName(source, eventArgs) {
        var tCategoryName = eventArgs.get_text().trim();
        var tCategoryID = eventArgs.get_value().split('~')[1].trim();
        document.getElementById('<%=txtFoodCatoName.ClientID %>').value = tCategoryName;
        document.getElementById('<%=hdnFoodCategoryID.ClientID %>').value = tCategoryID;
    }


    //-----------------------------------------------END----------------------------------------------
        
</script>

