<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionFoodCategory.ascx.cs"
    Inherits="CommonControls_NutritionFoodCategory" %>
<script  type ="text/javascript"  language ="javascript" >
var list={Update:'<%=Resources.ClientSideDisplayTexts.Common_Update %>',clear:'<%=Resources.ClientSideDisplayTexts.Common_clear %>',
ADD:'<%=Resources.ClientSideDisplayTexts.Common_Save %>',Cancel:'<%=Resources.ClientSideDisplayTexts.Common_cancel %>'};
</script>
<script type="text/javascript">
    //---------------------------------------NRRAJAN-------------------------------------


    function extractRow(SelClientID, FoodCategoryID, FoodCategoryName, Disp) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(SelClientID).checked = true;
        document.getElementById('<%=hdnCatoID.ClientID%>').value = FoodCategoryID;
        document.getElementById('<%=txtNutritionName.ClientID%>').value = FoodCategoryName;
        document.getElementById('<%=txtDescrp.ClientID%>').value = Disp;
        document.getElementById('<%=btnSave.ClientID%>').value = list .Update ;
        document.getElementById('<%=hdnbtnSave.ClientID%>').value = list .Update ;

    }
    function ValidationDiet_Cato() {

        if (document.getElementById('<%=txtNutritionName.ClientID%>').value.trim() == '') {
            var userMsg = SListForApplicationMessages.Get("CommonControls\\NutritionFoodCategory.ascx_1");
            if (userMsg != null) {
                alert(userMsg);
                document.getElementById('<%=txtNutritionName.ClientID%>').focus();
                return false;

            } else {

                alert('Provide FoodCategory Name');
                document.getElementById('<%=txtNutritionName.ClientID%>').focus();
                return false;
            }
        }
    }
     function FoodCategoryFnClear() {

           document.getElementById('<%= txtNutritionName.ClientID %>').value = '';
                document.getElementById('<%= txtDescrp.ClientID %>').value = '';
            document.getElementById('<%= btnSave.ClientID %>').value = list.ADD ;
            document.getElementById('<%= hdnbtnSave.ClientID %>').value = list.ADD ;
              document.getElementById('<%=btnCanecl.ClientID %>').value = list.Cancel ;
             
          var gridId = document.getElementById("<%= grdResult.ClientID %>");
        var gdrowcount = document.getElementById("<%= grdResult.ClientID %>").rows.length;
        for (var i = 1; i < gdrowcount; i++) {
            var inputs = gridId.rows[i].getElementsByTagName('input');
            for (var j = 0; j < inputs.length; j++) {
                if (inputs[j].type == "radio")
                    inputs[j].checked = false;
            }
        }
             return false;
        }    
        
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder"
    align="center">
    <tr>
        <td>
            <div class="contentdata1">
                <asp:UpdatePanel ID="updatePanel2" runat="server">
                    <ContentTemplate>
                        <table class="dataheader2 defaultfontcolor" width="100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblNutritionName" runat="server" Text="Food Category Name" meta:resourcekey="lblNutritionNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtNutritionName" MaxLength="255" CssClass="Txtboxsmall" runat="server"
                                                    meta:resourcekey="txtNutritionNameResource1"></asp:TextBox>
                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lbdescription0" runat="server" meta:resourcekey="lbdescriptionResource1"
                                                    Text="Description"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescrp" runat="server" meta:resourcekey="txtDescrpResource1"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" CssClass="btn" meta:resourcekey="btnSaveResource1"
                                                    OnClick="btnSave_Click" OnClientClick="return ValidationDiet_Cato();" Text=" Save "
                                                    ToolTip="Click here to Save" />
                                                <asp:Button ID="btnCanecl" runat="server" CssClass="btn" meta:resourcekey="btnCaneclResource1"
                                                    OnClientClick="return FoodCategoryFnClear();" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" TabIndex="4" Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="hdnbtnSave" runat="server" />
                        <table id="Table1" class="dataheader2 defaultfontcolor" width="100%">
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="1" CellSpacing="1" CssClass="mytable1"  meta:resourcekey="grdResultResource1"
                                        OnPageIndexChanging="grdResult_PageIndexChanging" OnRowDataBound="grdResult_RowDataBound"
                                        Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdSel" runat="server" GroupName="OrderSelect" meta:resourcekey="rdSelResource1"
                                                        ToolTip="Select Row" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FoodCategoryID" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsDiscountable" runat="server" meta:resourcekey="lblIsDiscountableResource1"
                                                        Text='<%# Eval("FoodCategoryID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Food Category Name" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFoodCategoryName" runat="server" meta:resourcekey="lblFoodCategoryNameResource1"
                                                        Text='<%# Eval("FoodCategoryName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionResource1"
                                                        Text='<%# Eval("Description") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="30%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                        <RowStyle HorizontalAlign="Left" />
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
<asp:HiddenField ID="hdnCatoID" runat="server" Value="0" />
