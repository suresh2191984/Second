<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FoodMenu.ascx.cs" Inherits="CommonControls_FoodMenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    var slist2 = { Update: '<%=Resources.ClientSideDisplayTexts.Common_Update %>', Save: '<%=Resources.ClientSideDisplayTexts.Common_Save %>' };
</script>

<script language="javascript" type="text/javascript">


    var userMsg;
    function foodmaster_checkDetails() {
        if (document.getElementById('<%=txtFoodMenuName.ClientID%>').value.trim() == '') {
            userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenu.ascx_1');
            if (userMsg != null) {
                alert(userMsg);

            }
            else {
                alert('Provide Menu name');

            }
            document.getElementById('<%=txtFoodMenuName.ClientID%>').focus();
            return false;
        }
        if (document.getElementById('<%=hdnIsDeletable.ClientID%>').value == "N" && document.getElementById('<%=btnFinish.ClientID%>').value == slist2 .Update) {
            if (document.getElementById('<%=chkDelete.ClientID%>').checked) {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenu.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);

                }
                else {
                    alert('Menu tagged against the product cannot be deleted');

                }
                document.getElementById('<%=chkDelete.ClientID%>').checked = false;
                document.getElementById('<%=btnFinish.ClientID%>').value = slist2.Save;
                return false;
            }
        }

    }

    function foodmaster_pageLoad() {
        document.getElementById('<%=txtFoodMenuName.ClientID%>').focus();
    }

    function foodmaster_SetValues(obj) {

        var x = obj.value.split('~');
        //            var isDeleted = x[3];
        //            var Isdeletable = x[4];
        //            if (isDeleted == "Y") {
        //                document.getElementById('tdbtnDelete').style.display = 'none';
        //                document.getElementById('chkDelete').checked = true;
        //                document.getElementById('hdnIsDeleted').value = 'Y';
        //            }
        //            else {
        //                document.getElementById('tdbtnDelete').style.display = 'block';
        //                document.getElementById('chkDelete').checked = false;
        //                document.getElementById('hdnIsDeleted').value = 'N';
        //            }
        //            if (Isdeletable == "Y") {
        //                document.getElementById('hdnIsDeletable').value = 'Y';
        //            }
        //            else {
        //                document.getElementById('hdnIsDeletable').value = 'N';
        //            }
        document.getElementById('<%=txtFoodMenuName.ClientID%>').value = x[1];
        document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value = x[1];
        document.getElementById('<%=txtDescription.ClientID%>').value = x[2];
        document.getElementById('<%=hdnId.ClientID%>').value = x[0];
        //            document.getElementById('ddlFrom').value = x[3];
        //            document.getElementById('ddlTo').value = x[4];
        document.getElementById('<%=btnFinish.ClientID%>').value = slist2.Update;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist2.Update;
        // document.getElementById('tdChkDelete').style.display = 'block';

    }
    function foodmaster_SetMasterValues(obj) {

        var x = obj.MenuName;
        var y = obj.MasterMenuID;

        document.getElementById('<%=txtFoodMenuName.ClientID%>').value = x;
        document.getElementById('<%=hdnId.ClientID%>').value = y;
        document.getElementById('<%=btnFinish.ClientID%>').value = slist2.Update;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist2.Update;
        // document.getElementById('tdChkDelete').style.display = 'block';

    }
    function foodmaster_FnClear() {

        $('#rdSel').removeAttr("checked");
        document.getElementById('<%=txtFoodMenuName.ClientID%>').value = '';
        document.getElementById('<%=txtDescription.ClientID%>').value = '';
        document.getElementById('<%=hdnIsDeleted.ClientID%>').value = '';
        document.getElementById('<%=hdnIsDeletable.ClientID%>').value = '';
        document.getElementById('<%=hdnId.ClientID%>').value = 0;
        document.getElementById('<%=btnFinish.ClientID%>').value = slist2.Save;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist2.Save;

        return false;
    }

    function foodmaster_showDeleteDiv(id) {
        if (document.getElementById(id).checked) {

            document.getElementById('<%=hdnIsDeleted.ClientID%>').value = 'Y';
        }
        else {

            document.getElementById('<%=hdnIsDeleted.ClientID%>hdnIsDeleted').value = 'N';
        }
    }

    function foodmaster_FnDelete() {

        if (document.getElementById('<%=hdnId.ClientID%>').value.trim() == 0 || document.getElementById('<%=txtFoodMenuName.ClientID%>').value.trim() == ''
                                                                    || document.getElementById('<%=hdnMenuToBeDel.ClientID%>').value != document.getElementById('<%=txtFoodMenuName.ClientID%>').value) {

            if (document.getElementById('<%=hdnId.ClientID%>').value.trim() == 0 && document.getElementById('<%=txtFoodMenuName.ClientID%>').value.trim() == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenu.ascx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select the Menu to delete');
                    return false;
                }

            } else {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenu.ascx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {

                    alert('Menu does not exist');
                    return false;
                }
            }

            return false;
        }

        if (!confirm('Do you wish to delete this Menu?')) {

            return false;

        }

        return true;
    }
    function foodmaster_MenuisSpclChar(e) {

        var key;
        var isCtrl = false;

        if (window.event) {
            key = e.keyCode;
        }
        else if (e.which) {
            key = e.which;
        }

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }

        return isCtrl;
    }





        
</script>

<div class="contentdata1">
    <ul>
        <li>
            <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
        </li>
    </ul>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table width="100%" class="dataheader2 defaultfontcolor" cellpadding="0" cellspacing="2">
                <tr>
                    <td>
                        <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                        <table>
                            <tr>
                                <td colspan="7" align="center">
                                    <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                    <input type="hidden" id="hdnStatus" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbcatgry" runat="server" Text="Menu Name" meta:resourcekey="lbcatgryResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFoodMenuName" runat="server" MaxLength="150" onkeypress="javascript:return foodmaster_MenuisSpclChar(event);"
                                        meta:resourcekey="txtFoodMenuNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteMenu" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" ServiceMethod="pGetMasterFoodMenuName" ServicePath="~/NutritionWebService.asmx"
                                        TargetControlID="txtFoodMenuName" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnMenuToBeDel" type="hidden" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lbdescrp" runat="server" Text="Description" meta:resourcekey="lbdescrpResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                    <input id="hdnIsDeleted" type="hidden" runat="server" />
                                    <input id="hdnIsDeletable" runat="server" type="hidden" />
                                </td>
                                <td>
                                    <asp:Button ID="btnFinish" Text=" Save " runat="server" 
                                        CssClass="btn" OnClientClick="javascript:return foodmaster_checkDetails();" 
                                        OnClick="btnFinish_Click" Height="26px" meta:resourcekey="btnFinishResource1" />
                                </td>
                                <td>
                                    <asp:Button ID="btnCancel" OnClientClick="javascript:return foodmaster_FnClear();"
                                        runat="server" Text=" Clear " CssClass="btn" 
                                         meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="100%" id="tblMenuGrid" runat="server" visible="False" class="dataheader2 defaultfontcolor"
                border="0" cellpadding="4" cellspacing="0">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                            Width="100%" AllowPaging="True" OnPageIndexChanging="gvMenu_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <input id="rdSel" name="radio" onclick="foodmaster_SetValues(this)" value='<%# Eval("FoodMenuID")+"~"+Eval("FoodMenuName")+"~"+ Eval("Description")%>'
                                            type="radio" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MenuName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" Text='<%#Eval("FoodMenuName") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Description" HeaderText="Description">
                                    <ItemStyle Width="35%" />
                                </asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="dataheader1" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div>
    <asp:CheckBox ID="chkDelete" runat="server" Visible="False" meta:resourcekey="chkDeleteResource1" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnMenuName" runat="server" />
</div>
