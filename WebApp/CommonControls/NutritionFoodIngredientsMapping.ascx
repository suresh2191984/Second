<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionFoodIngredientsMapping.ascx.cs"
    Inherits="CommonControls_FoodIngredientsMapping" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

<asp:HiddenField ID="hdnMessages" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
    <tr>
        <td>
            <asp:UpdatePanel ID="UpdatePane" runat="server">
                <ContentTemplate>
                    <div class="contentdata1">
                        <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                            cellspacing="0">
                            <tr>
                                <td colspan="9" align="center">
                                    &nbsp;<asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label><input
                                        type="hidden" id="hdnStatus" runat="server" />
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <asp:Label ID="lbcatgry" runat="server" Text="Food Name" meta:resourcekey="lbcatgryResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFoodName"  runat="server" MaxLength="255" CssClass="searchBox"
                                        meta:resourcekey="txtFoodNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteMenu" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" ServiceMethod="GetFoodName" ServicePath="~/NutritionWebService.asmx"
                                        TargetControlID="txtFoodName" OnClientItemSelected="OnSelectFoodNameChange" DelimiterCharacters=""
                                        Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnMenuToBeDel" type="hidden" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lbdescrp" runat="server" Text="Ingredient" meta:resourcekey="lbdescrpResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIng"  runat="server" MaxLength="255" CssClass="searchBox"
                                        meta:resourcekey="txtIngResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" ServiceMethod="pGetFoodIngredientName" ServicePath="~/NutritionWebService.asmx"
                                        TargetControlID="txtIng" OnClientItemSelected="OnSelectIngredient" DelimiterCharacters=""
                                        Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnIngDeleted" type="hidden" runat="server" />
                                    <input id="hdnIsDeletable" runat="server" type="hidden" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblQty" runat="server" Text="Quantity" meta:resourcekey="lblQtyResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtQty" Width="150px" runat="server" MaxLength="255" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtQtyResource1"></asp:TextBox>
                                          &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <input id="Hidden1" type="hidden" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblUOM" runat="server" Text="UOM" meta:resourcekey="lblUOMResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlUOM" runat="server"  CssClass="ddlsmall"  meta:resourcekey="ddlUOMResource1">
                                    </asp:DropDownList>
                                      &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td id="td4" runat="server" align="center">
                                    <input type="button" id="btnAdd" onclick="displayResult()" value="Add" runat="server" />
                                    <input type="hidden" id="GetBtnValue" value="Add" runat="server" />
                                    <input type="hidden" id="GetUpdateValue" value="" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="9">
                                    <table id="myTable" width="50%" class="mytable1" border="1" runat="server">
                                        <thead>
                                            <tr>
                                                <th style="width: 200px;">
                                                    <asp:Label ID="tdlblIngredients" runat="server" Text="Ingredients" meta:resourcekey="tdlblIngredientsResource1"></asp:Label>
                                                </th>
                                                <th visible="false">
                                                 <asp:Label ID="labelQunty" runat="server" Text="Quantity" meta:resourcekey="labelQuntyResource1"></asp:Label>
                                                </th>
                                                <th visible="false">
                                                <asp:Label ID="labeluom" runat="server" Text="Uom" meta:resourcekey="labeluomResource1"></asp:Label>
                                                </th>
                                                <th>
                                                <asp:Label ID="tdlblQuanUom" runat="server" Text="Quantity/Uom" meta:resourcekey="tdlblQuanUomResource1"></asp:Label>
                                                    
                                                </th>
                                                <th colspan="2">
                                                 <asp:Label ID="tdlblSelect" runat="server" Text="select" meta:resourcekey="tdlblselectResource1"></asp:Label>                                                   
                                                </th>
                                            </tr>
                                        </thead>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" align="center">
                                    <table>
                                        <tr>
                                            <td id="td2" runat="server" align="center">
                                                <asp:Button ID="btnFinish" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnFinish_Click" OnClientClick="GetTableValues()"
                                                    Height="26px" meta:resourcekey="btnFinishResource1" />
                                                &nbsp;
                                            </td>
                                            <td id="td3" style="display: none" runat="server">
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="btnCancel" OnClientClick="javascript:return FnClearValues();" runat="server"
                                                    Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    meta:resourcekey="btnCancelResource1" Visible="true" />
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                            cellspacing="0">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvFoodIngredientsMapping" runat="server" AutoGenerateColumns="False"
                                        CssClass="mytable1" Width="100%" AllowPaging="True" OnPageIndexChanging="gvFoodIngredientsMapping_PageIndexChanging"
                                        PageSize="5" meta:resourcekey="gvFoodIngredientsMappingResource1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <input id="rdSel" name="radio" value='<%# Eval("CombineValue") %>' onclick="HtmlOnClickUpdate(this)"
                                                        type="radio" />
                                                    <asp:HiddenField ID="hdnFoodIdValue" runat="server" Value="0" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FoodName" HeaderText="Food Name" meta:resourcekey="BoundFieldResource1">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Food Ingredients" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCombineData" runat="server" Text='<%# Eval("CombineData") %>' meta:resourcekey="lblCombineDataResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="50%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="dataheader1" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnMenuName" runat="server" />
<asp:HiddenField ID="htntableValues" runat="server" />
<asp:HiddenField ID="htntableValues1" runat="server" />
<asp:HiddenField ID="hdnId" runat="server" Value="0" />
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
<script language="javascript" type="text/javascript">
    var Ingrednt_list = { Update: '<%=Resources.ClientSideDisplayTexts.Common_Update %>', Save: '<%=Resources.ClientSideDisplayTexts.Common_Save %>',
    Add:'<%=Resources.ClientSideDisplayTexts.Common_Edit%>' };
</script>
<script language="javascript" type="text/javascript">

    var userMsg = null;
    function pageLoad() {
        //document.getElementById('<%=txtFoodName.ClientID%>').focus();

    }
    function GetTableValues() {    
        document.getElementById('<%=htntableValues1.ClientID%>').value = '';
        var table = document.getElementById('<%=myTable.ClientID%>');
        for (var i = 1; i < table.rows.length; i++) {
            var inputs = table.rows[i].getElementsByTagName('input');
            var MappingId = table.rows[i].cells[12].innerHTML;
            var FoodId = table.rows[i].cells[2].innerHTML;
            var FoodName = table.rows[i].cells[3].innerHTML;
            var IngId = table.rows[i].cells[4].innerHTML;
            var IngName = table.rows[i].cells[5].innerHTML;
            var Quantity = table.rows[i].cells[6].innerHTML;
            var UomId = table.rows[i].cells[8].innerHTML;
            var Val = MappingId + '~' + FoodId + '~' + FoodName + '~' + IngId + '~' + IngName + '~' + Quantity + '~' + UomId;
            var hdntableValue = Val;
            var HdnControlValue = document.getElementById('<%=htntableValues1.ClientID%>').value;
            if (HdnControlValue == "") {
                document.getElementById('<%=htntableValues1.ClientID%>').value = hdntableValue;
            }
            else {
                document.getElementById('<%=htntableValues1.ClientID%>').value = HdnControlValue + '^' + hdntableValue;
            }
            document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = FoodId;
            document.getElementById('<%=txtFoodName.ClientID%>').value = FoodName;
            document.getElementById('<%=txtFoodName.ClientID%>').disabled = true;
        }
    }

    function HtmlOnClickUpdate(obj) {
        var htnTablerows = obj.value;
        document.getElementById('<%=btnFinish.ClientID%>').value = Ingrednt_list.Update;
        document.getElementById('<%=hdnStatus.ClientID%>').value = Ingrednt_list.Update;
        var table = document.getElementById('<%=myTable.ClientID%>');
        var countRow = 0;
        document.getElementById('<%=btnFinish.ClientID%>').value = Ingrednt_list.Update;
        var i = table.rows.length;
        for (i; i > 1; i--) {
            table.deleteRow(i - 1);
        }
        if (htnTablerows != "") {
            var splitRows = htnTablerows.split('^');
            for (var i = 0; i < splitRows.length; i++) {
                if (splitRows[i] != "") {

                    var SpiltCells = splitRows[i].split('~');
                    var row = table.insertRow(1);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);
                    var cell13 = row.insertCell(12);
                    countRow++;
                    var MappingId = SpiltCells[0];
                    var MenuId = SpiltCells[1];
                    var MenuName = SpiltCells[2];
                    var IngId = SpiltCells[3];
                    var IngName = SpiltCells[4];
                    var Quantity = SpiltCells[5];
                    var UOMId = SpiltCells[6];
                    var UOMtext = SpiltCells[7];
                    cell1.style.display = 'none';
                    cell2.style.display = 'none';
                    cell3.style.display = 'none';
                    cell4.style.display = 'none';
                    cell5.style.display = 'none';
                    cell7.style.display = 'none';
                    cell8.style.display = 'none';
                    cell9.style.display = 'none';
                    cell13.style.display = 'none';
                    var Val = countRow + '~' + MappingId + '~' + MenuId + '~' + MenuName + '~' + IngId + '~' + IngName + '~' + Quantity + '~' + UOMId + '~' + UOMtext;
                    cell1.innerHTML = countRow;
                    cell2.innerHTML = '<input id="rdSel1" name="radio"  onclick="SetEditValues(this)" value="' + Val + '" type="radio" />';
                    cell3.innerHTML = MenuId;
                    cell4.innerHTML = MenuName;
                    cell5.innerHTML = IngId;
                    cell6.innerHTML = IngName;
                    cell7.innerHTML = Quantity;
                    cell8.innerHTML = UOMtext;
                    cell9.innerHTML = UOMId;
                    cell10.innerHTML = Quantity + '/' + UOMtext;
                    cell11.innerHTML = '<input id="lbtnEdit" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Edit %>" onclick="SetEditValues(this)" type="button" style="background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer"  />';
                    cell12.innerHTML = '<input id="lbtnDelete" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Delete %>" onclick="DeleteValues(this)" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                    cell13.innerHTML = MappingId;
                    document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = MenuId;
                    document.getElementById('<%=txtFoodName.ClientID%>').value = MenuName;
                    document.getElementById('<%=txtFoodName.ClientID%>').disabled = true;
                    document.getElementById('<%=lblmsg.ClientID%>').value = '';
                    var hdntableValue = Val;
                    var HdnControlValue = document.getElementById('<%=htntableValues.ClientID%>').value;
                    if (HdnControlValue == "") {
                        document.getElementById('<%=htntableValues.ClientID%>').value = hdntableValue;
                    }
                    else {
                        document.getElementById('<%=htntableValues.ClientID%>').value = HdnControlValue + '^' + hdntableValue;
                    }


                }
            }
        }
    }

    function checkValidation() {
        var MenuName = document.getElementById('<%=txtFoodName.ClientID%>').value;
        var IngName = document.getElementById('<%=txtIng.ClientID%>').value;
        var Quantity = document.getElementById('<%=txtQty.ClientID%>').value;
        var UOM = document.getElementById('<%=ddlUOM.ClientID%>').selectedIndex;
        if (MenuName == '' || IngName == '' || Quantity == '' || UOM == '0') {
            if (MenuName == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionFoodIngredientsMapping.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Provide Food Menu name');
                }
                document.getElementById('<%=txtFoodName.ClientID%>').focus();
                return false;
            }

            else if (IngName == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionFoodIngredientsMapping.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Provide Food Ingredients name');
                }
                document.getElementById('<%=txtIng.ClientID%>').focus();
                return false;
            }
            else if (Quantity == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionFoodIngredientsMapping.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Provide Food Quantity name');
                }
                document.getElementById('<%=txtQty.ClientID%>').focus();
                return false;
            }
            else if (UOM == '0') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionFoodIngredientsMapping.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Please Select the Food UOM');
                }

                document.getElementById('<%=ddlUOM.ClientID%>').focus();
                return false;
            }
        }
    }


    function FnClear() {
        document.getElementById('<%=txtFoodName.ClientID%>').disabled = true;
        document.getElementById('<%=hdnIngDeleted.ClientID%>').value = '';
        document.getElementById('<%=txtIng.ClientID%>').value = '';
        document.getElementById('<%=txtQty.ClientID%>').value = '';
        document.getElementById('<%=ddlUOM.ClientID%>').value = '0';
        document.getElementById('<%=btnAdd.ClientID%>').value = Ingrednt_list.Add;
        document.getElementById('<%=GetBtnValue.ClientID%>').value = Ingrednt_list.Add ;
        var gridId = document.getElementById('<%=myTable.ClientID%>');
        var gdrowcount = document.getElementById('<%=myTable.ClientID%>').rows.length;
        for (var i = 1; i < gdrowcount; i++) {
            var inputs = gridId.rows[i].getElementsByTagName('input');
            for (var j = 0; j < inputs.length; j++) {
                if (inputs[j].type == "radio")
                    inputs[j].checked = false;
            }
        }
        return false;
    }

    function OnSelectFoodNameChange(source, eventArgs) {
        try {
            var tMenuName = eventArgs.get_text().trim();
            var tMenuID = eventArgs.get_value();
            document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = tMenuID;
            document.getElementById('<%=txtFoodName.ClientID%>').value = tMenuName;
        }
        catch (e) {
            return false;
        }
    }

    function OnSelectIngredient(source, eventArgs) { 
        try {
            var tMenuName = eventArgs.get_text().trim();
            var tMenuID = eventArgs.get_value();
            document.getElementById('<%=hdnIngDeleted.ClientID%>').value = tMenuID;
            document.getElementById('<%=txtIng.ClientID%>').value = tMenuName;
        }
        catch (e) {
            return false;
        }
    }

    function displayResult(obj) {
        if (checkValidation() != false) {
            if (document.getElementById('<%=GetBtnValue.ClientID%>').value != Ingrednt_list.Update ) {
                var table = document.getElementById('<%=myTable.ClientID%>');
                if (table.rows.length > 0) {
                    for (var d = 1; d < table.rows.length; d++) {
                        if (table.rows[d].cells[4].innerHTML == document.getElementById('<%=hdnIngDeleted.ClientID%>').value) {
                            alert('The Ingredient Name already in list');
                            return;
                        }
                    }
                }
                var row = table.insertRow(1);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);
                var cell13 = row.insertCell(12);
                var count = table.rows.length;
                var MappingId = 0;
                var MenuId = document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value;
                var MenuName = document.getElementById('<%=txtFoodName.ClientID%>').value;
                var IngId = document.getElementById('<%=hdnIngDeleted.ClientID%>').value;
                var IngName = document.getElementById('<%=txtIng.ClientID%>').value;
                var Quantity = document.getElementById('<%=txtQty.ClientID%>').value;
                var UOM = document.getElementById('<%=ddlUOM.ClientID%>');
                var UOMId = UOM.options[UOM.selectedIndex].value
                var UOMtext = UOM.options[UOM.selectedIndex].text
                cell1.style.display = 'none';
                cell2.style.display = 'none';
                cell3.style.display = 'none';
                cell4.style.display = 'none';
                cell5.style.display = 'none';
                cell7.style.display = 'none';
                cell8.style.display = 'none';
                cell9.style.display = 'none';
                cell13.style.display = 'none';
                var Val = count + '~' + MappingId + '~' + MenuId + '~' + MenuName + '~' + IngId + '~' + IngName + '~' + Quantity + '~' + UOMId + '~' + UOMtext;
                cell1.innerHTML = count;
                cell2.innerHTML = '<input id="rdSel1" name="radio"  onclick="SetEditValues(this)" value="' + Val + '" type="radio" visible="false" />';
                cell3.innerHTML = MenuId;
                cell4.innerHTML = MenuName;
                cell5.innerHTML = IngId;
                cell6.innerHTML = IngName;
                cell7.innerHTML = Quantity;
                cell8.innerHTML = UOMtext;
                cell9.innerHTML = UOMId;
                cell10.innerHTML = Quantity + '/' + UOMtext;
                cell11.innerHTML = '<input id="lbtnEdit" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Edit %>" onclick="SetEditValues(this)" type="button" style="background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer"  />';
                cell12.innerHTML = '<input id="lbtnDelete" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Delete %>" onclick="DeleteValues(this)" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                cell13.innerHTML = MappingId;
                var hdntableValue = Val;
                var HdnControlValue = document.getElementById('<%=htntableValues.ClientID%>').value;
                if (HdnControlValue == "") {
                    document.getElementById('<%=htntableValues.ClientID%>').value = hdntableValue;
                }
                else {
                    document.getElementById('<%=htntableValues.ClientID%>').value = HdnControlValue + '^' + hdntableValue;
                }
            }
            else {
                var x = document.getElementById('<%=GetUpdateValue.ClientID%>').value.split('~');
                var table = document.getElementById('<%=myTable.ClientID%>');
                var rowCount = table.rows.length;
                for (var i = 1; i < rowCount; i++) {
                    var CellValue = table.rows[i].cells[0].innerHTML;
                    if (x[0] == CellValue) {
                        if (table.rows.length > 0) {
                            for (var d = 1; d < table.rows.length; d++) {
                                if (table.rows[d].cells[4].innerHTML == document.getElementById('<%=hdnIngDeleted.ClientID%>').value && table.rows[d].cells[0].innerHTML != CellValue) {
                                    alert('The Ingredient Name already in list');
                                    return;
                                }
                            }
                        }
                        var MenuId = document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value;
                        var MenuName = document.getElementById('<%=txtFoodName.ClientID%>').value;
                        var IngId = document.getElementById('<%=hdnIngDeleted.ClientID%>').value;
                        var IngName = document.getElementById('<%=txtIng.ClientID%>').value;
                        var Quantity = document.getElementById('<%=txtQty.ClientID%>').value;
                        var UOM = document.getElementById('<%=ddlUOM.ClientID%>');
                        var UOMId = UOM.options[UOM.selectedIndex].value
                        var UOMtext = UOM.options[UOM.selectedIndex].text
                        var Val = x[0] + '~' + x[1] + '~' + MenuId + '~' + MenuName + '~' + IngId + '~' + IngName + '~' + Quantity + '~' + UOMId + '~' + UOMtext;
                        table.rows[i].cells[1].innerHTML = '<input id="rdSel1" name="radio"  onclick="SetEditValues(this)" value="' + Val + '" type="radio" visible="false" />';
                        table.rows[i].cells[2].innerHTML = MenuId;
                        table.rows[i].cells[3].innerHTML = MenuName;
                        table.rows[i].cells[4].innerHTML = IngId;
                        table.rows[i].cells[5].innerHTML = IngName;
                        table.rows[i].cells[6].innerHTML = Quantity;
                        table.rows[i].cells[7].innerHTML = UOMtext;
                        table.rows[i].cells[8].innerHTML = UOMId
                        table.rows[i].cells[9].innerHTML = Quantity + '' + UOMtext;
                        table.rows[i].cells[10].innerHTML = '<input id="lbtnEdit" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Edit %>" onclick="SetEditValues(this)" type="button" style="background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer"  />';
                        table.rows[i].cells[11].innerHTML = '<input id="lbtnDelete" name="' + Val + '" value="<%=Resources.ClientSideDisplayTexts.Common_Delete %>" onclick="DeleteValues(this)" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                        table.rows[i].cells[12].innerHTML = x[1];
                    }
                }
            }
            FnClear();
        }
    }
    function SetEditValues(obj) {
        var x = obj.name.split('~');
        document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = x[2];
        document.getElementById('<%=txtFoodName.ClientID%>').value = x[3];
        document.getElementById('<%=hdnIngDeleted.ClientID%>').value = x[4];
        document.getElementById('<%=txtIng.ClientID%>').value = x[5];
        document.getElementById('<%=txtQty.ClientID%>').value = x[6];
        document.getElementById('<%=ddlUOM.ClientID%>').value = x[7];
        if (document.getElementById('<%=btnAdd.ClientID%>').value == Ingrednt_list.Add ) {
            document.getElementById('<%=btnAdd.ClientID%>').value = Ingrednt_list.Update ;
            document.getElementById('<%=GetBtnValue.ClientID%>').value = Ingrednt_list.Update ;
            document.getElementById('<%=GetUpdateValue.ClientID%>').value = obj.name;
        }
    }

    function DeleteValues(obj) {
        var x = obj.name.split('~');
        var table = document.getElementById('<%=myTable.ClientID%>');
        var rowCount = table.rows.length;
        for (var i = 1; i < rowCount; i++) {
            var CellValue = table.rows[i].cells[0].innerHTML;
            if (x[0] == CellValue) {
                table.deleteRow(i);
                break;
            }
        }
        rowCount = table.rows.length;
        if (rowCount == 0) {
            document.getElementById('<%=btnAdd.ClientID%>').value == Ingrednt_list.Add ;
            document.getElementById('<%=GetBtnValue.ClientID%>').value = Ingrednt_list.Add ;
            document.getElementById('<%=txtFoodName.ClientID%>').disabled = false;
            //  document.getElementById('<%=txtFoodName.ClientID%>').value = '';
        }
    }

    function FnClearValues() {
        document.getElementById('<%=txtFoodName.ClientID%>').disabled = true;
        document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = '';
        document.getElementById('<%=txtFoodName.ClientID%>').value = '';
        document.getElementById('<%=hdnIngDeleted.ClientID%>').value = '';
        document.getElementById('<%=txtIng.ClientID%>').value = '';
        document.getElementById('<%=txtQty.ClientID%>').value = '';
        document.getElementById('<%=ddlUOM.ClientID%>').selectedIndex = '0';
        document.getElementById('<%=btnAdd.ClientID%>').value == Ingrednt_list.Add;
        document.getElementById('<%=btnFinish.ClientID%>').value = Ingrednt_list.Save ;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = Ingrednt_list.Save ;
        var table = document.getElementById('<%=myTable.ClientID%>');
        var rowCount = table.rows.length;
        for (var i = 1; i < rowCount; i++) {
            table.deleteRow(i);
            break;
        }
        if (document.getElementById("<%= gvFoodIngredientsMapping.ClientID %>") != null) {
            var gridId = document.getElementById("<%= gvFoodIngredientsMapping.ClientID %>");
            var gdrowcount = document.getElementById("<%= gvFoodIngredientsMapping.ClientID %>").rows.length;
            for (var i = 1; i < gdrowcount; i++) {
                var inputs = gridId.rows[i].getElementsByTagName('input');
                for (var j = 0; j < inputs.length; j++) {
                    if (inputs[j].type == "radio")
                        inputs[j].checked = false;
                }
            } 
        }
    }
</script>

