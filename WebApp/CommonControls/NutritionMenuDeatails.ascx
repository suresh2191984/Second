<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NutritionMenuDeatails.ascx.cs"
    Inherits="CommonControls_NutritionMenuDeatails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<asp:HiddenField ID="hdnMessages" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
    <tr>
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="contentdata1">
                        <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                        <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                            cellspacing="0">
                            <tr>
                                <td colspan="6" align="center">
                                    &nbsp;<asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label><input
                                        type="hidden" id="hdnStatus" runat="server" value="Save" />
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <asp:Label ID="lbMenuName" runat="server" Text="Menu Name" meta:resourcekey="lbMenuNameResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtMenuName" runat="server" MaxLength="255" CssClass="searchBox"
                                        AutoPostBack="True" meta:resourcekey="txtMenuNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender CompletionInterval="1" ID="autoCompExtPhys" runat="server"
                                        TargetControlID="txtMenuName" EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="1"
                                        CompletionListCssClass="listtwo" OnClientItemSelected="OnSelectMenuDetailsName"
                                        CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        ServiceMethod="GetFoodMenuNameService" ServicePath="~/NutritionWebService.asmx"
                                        DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnMenuNametoBeDel" type="hidden" runat="server" />
                                    <input id="hdnMenuDetailsNametoBeDel" runat="server" type="hidden" value="0" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lbFoodName" runat="server" Text="Food Name" meta:resourcekey="lbFoodNameResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFoodName" runat="server" MaxLength="255" CssClass="searchBox"
                                        meta:resourcekey="txtFoodNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" OnClientItemSelected="OnSelectFoodChange" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" ServiceMethod="GetFoodName" ServicePath="~/NutritionWebService.asmx"
                                        TargetControlID="txtFoodName" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnFoodNameToBeDel" type="hidden" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lbFoodSession" runat="server" Text="Session Name" meta:resourcekey="lbFoodSessionResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFSeessionName" runat="server" MaxLength="255" CssClass="searchBox"
                                        meta:resourcekey="txtFSeessionNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" OnClientItemSelected="OnSelectDetailsSessionName"
                                        CompletionListHighlightedItemCssClass="hoverlistitemtwo" CompletionListItemCssClass="listitemtwo"
                                        EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetFoodsessionService"
                                        ServicePath="~/NutritionWebService.asmx" TargetControlID="txtFSeessionName" DelimiterCharacters=""
                                        Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="htnFSessiontoBeDel" type="hidden" runat="server" />
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <asp:Label ID="lbQuantity" runat="server" Text="Quantity" meta:resourcekey="lbQuantityResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtQuantity" runat="server" MaxLength="255" CssClass="Txtboxsmall"
                                        onkeydown=" return isNumerics(event,this.id)" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <input id="hdnQuantity" type="hidden" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lbUom" runat="server" Text="UOM" meta:resourcekey="lbUomResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlUom" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlUomResource1">
                                    </asp:DropDownList>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <input id="htnUomtoBeDel" type="hidden" runat="server" />
                                </td>
                                <td align="left" colspan="5">
                                    <table>
                                        <tr>
                                            <td id="tdChkDelete" runat="server" style="display: none">
                                                <asp:CheckBox ID="chkDelete" Visible ="false" runat="server" Text="Delete Food Menu Details" meta:resourcekey="chkDeleteResource1" />
                                            </td>
                                            <td id="tdbtnFinish" runat="server">
                                                <asp:Button ID="btnFinish" runat="server" OnClick="btnFinish_Click" CssClass="btn"
                                                    Height="26px" OnClientClick="javascript:return checkFoodMenuDetails();" Text="Save"
                                                    meta:resourcekey="btnFinishResource1" />
                                                &nbsp;
                                            </td>
                                            <td id="tdbtnDelete" runat="server" style="display: none">
                                            </td>
                                            <td>
                                                <asp:Button ID="btnCancel" OnClientClick="javascript:return FnClearMenuDetails();"
                                                    runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" id="tblFoodMenuDetailGrid" runat="server" class="dataheader2 defaultfontcolor"
                            border="0" cellpadding="4" cellspacing="0">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" runat="server">
                                    <asp:GridView ID="gvFoodMenuDetails" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                                        Width="100%" AllowPaging="True" OnPageIndexChanging="gvFoodMenuDetails_PageIndexChanging"
                                        PageSize="5">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <input id="rdSel" name="radio" onclick="SetFoodMenuDetailValues(this)" value='<%# Eval("FoodMenuDetailID")+"~"+Eval("FoodMenuID")+"~"+Eval("FoodMenuName")+"~"+Eval("FoodID")+"~"+ Eval("FoodName")+"~"+Eval("FoodSessionID")+"~"+ Eval("FoodSessionName")+"~"+ Eval("Quantity")+"~"+ Eval("Uom")%>'
                                                        type="radio" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FoodMenuName" HeaderText="Menu Name">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FoodName" HeaderText="Food Name">
                                                <ItemStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FoodSessionName" HeaderText="Food Session Name">
                                                <ItemStyle Width="25%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity">
                                                <ItemStyle Width="25%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="UOMCode" HeaderText="Uom">
                                                <ItemStyle Width="20%" />
                                            </asp:BoundField>
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
    var menudeatail_list = { Update: '<%=Resources.ClientSideDisplayTexts.Common_Update %>', Save: '<%=Resources.ClientSideDisplayTexts.Common_Save %>' };
</script>

<script type="text/javascript">
    var userMsg;
    function checkFoodMenuDetails() {
        var MenuName = document.getElementById('<%=txtMenuName.ClientID%>').value;
        var SessionName = document.getElementById('<%=txtFSeessionName.ClientID%>').value;
        var FoodName = document.getElementById('<%=txtFoodName.ClientID%>').value;
        var Quantity = document.getElementById('<%=txtQuantity.ClientID%>').value;
        var UOM = document.getElementById('<%=ddlUom.ClientID%>').selectedIndex;
        if (MenuName == '' || SessionName == '' || FoodName == '' || Quantity == '' || UOM == '0') {
            if (MenuName == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionMenuDeatails.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Provide Food Menu name');
                }
                document.getElementById('<%=txtMenuName.ClientID%>').focus();
                return false;
            }
            else if (FoodName == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionMenuDeatails.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Provide Food Name');
                }
                document.getElementById('<%=txtFoodName.ClientID%>').focus();
                return false;
            }
            else if (SessionName == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionMenuDeatails.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Provide Food Session Menu name');
                }
                document.getElementById('<%=txtFSeessionName.ClientID%>').focus();
                return false;
            }
            else if (Quantity == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionMenuDeatails.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Provide the Quantity');
                }
                document.getElementById('<%=txtQuantity.ClientID%>').focus();
                return false;
            }
            else if (UOM == '0') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\NutritionMenuDeatails.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Please Select the UOM');
                }
                document.getElementById('<%=ddlUom.ClientID%>').focus();
                return false;
            }
        }
    }

    function OnSelectMenuDetailsName(source, eventArgs) {
        try {
            var tMenuName = eventArgs.get_text().trim();
            var tMenuID = eventArgs.get_value();
            document.getElementById('<%=hdnMenuNametoBeDel.ClientID%>').value = tMenuID;
            document.getElementById('<%=txtMenuName.ClientID%>').value = tMenuName;
        }
        catch (e) {
            return false;
        }
    }
    function OnSelectDetailsSessionName(source, eventArgs) {
        try {
            var tSessionName = eventArgs.get_text().trim();
            var tSessionID = eventArgs.get_value();
            document.getElementById('<%=txtFSeessionName.ClientID%>').value = tSessionName;
            document.getElementById('<%=htnFSessiontoBeDel.ClientID%>').value = tSessionID;
        }
        catch (e) {
            return false;
        }
    }
    function OnSelectFoodChange(source, eventArgs) {
        try {
            var tFoodName = eventArgs.get_text().trim();
            var tFoodID = eventArgs.get_value();
            document.getElementById('<%=txtFoodName.ClientID%>').value = tFoodName;
            document.getElementById('<%=hdnFoodNameToBeDel.ClientID%>').value = tFoodID;
        }
        catch (e) {
            return false;
        }
    }

    function pageLoad() {
        document.getElementById('<%=txtMenuName.ClientID%>').focus();
    }

    function SetFoodMenuDetailValues(obj) {
        var x = obj.value.split('~');
        document.getElementById('<%=hdnMenuDetailsNametoBeDel.ClientID%>').value = x[0];
        document.getElementById('<%=hdnMenuNametoBeDel.ClientID%>').value = x[1];
        document.getElementById('<%=txtMenuName.ClientID%>').value = x[2];
        document.getElementById('<%=hdnFoodNameToBeDel.ClientID%>').value = x[3];
        document.getElementById('<%=txtFoodName.ClientID%>').value = x[4];
        document.getElementById('<%=htnFSessiontoBeDel.ClientID%>').value = x[5];
        document.getElementById('<%=txtFSeessionName.ClientID%>').value = x[6];
        document.getElementById('<%=txtQuantity.ClientID%>').value = x[7];
        document.getElementById('<%=ddlUom.ClientID%>').value = x[8];
        document.getElementById('<%=btnFinish.ClientID%>').value = menudeatail_list.Update ;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = menudeatail_list .Update ;
        document.getElementById('<%=tdChkDelete.ClientID%>').style.display = 'block';

    }

    function FnClearMenuDetails() {
        document.getElementById('<%=hdnMenuDetailsNametoBeDel.ClientID%>').value = '0';
        document.getElementById('<%=txtMenuName.ClientID%>').value = '';
        document.getElementById('<%=txtFoodName.ClientID%>').value = '';
        document.getElementById('<%=txtFSeessionName.ClientID%>').value = '';
        document.getElementById('<%=txtQuantity.ClientID%>').value = '';
        document.getElementById('<%=ddlUom.ClientID%>').value = '0';
        document.getElementById('<%=btnFinish.ClientID%>').value = menudeatail_list .Save ;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = menudeatail_list .Save ;
        document.getElementById('<%=tdChkDelete.ClientID%>').style.display = 'none';
        if (document.getElementById("<%= gvFoodMenuDetails.ClientID %>") != null) {
            var gridId = document.getElementById("<%= gvFoodMenuDetails.ClientID %>");
            var gdrowcount = document.getElementById("<%= gvFoodMenuDetails.ClientID %>").rows.length;
            for (var i = 1; i < gridId.rows.length; i++) {
                var inputs = gridId.rows[i].getElementsByTagName('input');
                for (var j = 0; j < inputs.length; j++) {
                    if (inputs[j].type == "radio")
                        inputs[j].checked = false;
                }
            }
        }
        return false;
    }

    function showDeleteDiv(id) {
        if (document.getElementById(id).checked) {
            document.getElementById('hdnIsDeleted').value = 'Y';
        }
        else {
            document.getElementById('hdnIsDeleted').value = 'N';
        }
    }

    function isNumerics(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;

        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                        isCtrl = false;
                }
            }
        } return isCtrl;
    }
   
    

</script>

