<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FoodSession.ascx.cs" Inherits="CommonControls_FoodSession" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    var slist = { Update: '<%=Resources.ClientSideDisplayTexts.Common_Update %>', Save: '<%=Resources.ClientSideDisplayTexts.Common_Save %>' };
</script>

<script language="javascript" type="text/javascript">
    var userMsg;
    function FoodSessioncheckDetails() {
        if (document.getElementById('<%=txtSessionName.ClientID%>').value.trim() == '') {
            userMsg = SListForApplicationMessages.Get('CommonControls\\FoodSession.ascx_1');
            if (userMsg != null) {
                alert(userMsg);

            }
            else {
                alert('Provide Session name');

            }
            document.getElementById('<%=txtSessionName.ClientID%>').focus();
            return false;
        }
        if (document.getElementById('<%=hdnIsDeletable.ClientID%>').value == "N" && document.getElementById('<%=btnFinish.ClientID%>').value == 'Update') {
            if (document.getElementById('<%=chkDelete.ClientID%>').checked) {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodSession.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);

                }
                else {
                    alert('Session tagged against the product cannot be deleted');

                }
                document.getElementById('<%=chkDelete.ClientID%>').checked = false;
                document.getElementById('<%=btnFinish.ClientID%>').value = slist.Save;
                return false;
            }
        }

    }

    function FoodSessionpageLoad() {
        document.getElementById('<%=txtSessionName.ClientID%>').focus();
    }

    function FoodSessionSetValues(obj) {

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
        document.getElementById('<%=txtSessionName.ClientID%>').value = x[1];
        document.getElementById('<%=hdnSessionToBeDel.ClientID%>').value = x[1];
        document.getElementById('<%=txtDescription.ClientID%>').value = x[2];
        document.getElementById('<%=hdnId.ClientID%>').value = x[0];
        //            document.getElementById('ddlFrom').value = x[3];
        //            document.getElementById('ddlTo').value = x[4];
        document.getElementById('<%=btnFinish.ClientID%>').value = slist.Update;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist.Update;
        // document.getElementById('tdChkDelete').style.display = 'block';

    }
    function FoodSessionSetMasterValues(obj) {

        var x = obj.SessionName;
        var y = obj.MasterSessionID;

        document.getElementById('<%=txtSessionName.ClientID%>').value = x;
        document.getElementById('<%=hdnId.ClientID%>').value = y;
        document.getElementById('<%=btnFinish.ClientID%>').value = slist.Update;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist.Update;
        // document.getElementById('tdChkDelete').style.display = 'block';

    }
    function FoodSessionFnClear() {


        document.getElementById('<%=txtSessionName.ClientID%>').value = '';
        document.getElementById('<%=txtDescription.ClientID%>').value = '';
        document.getElementById('<%=hdnIsDeleted.ClientID%>').value = '';
        document.getElementById('<%=hdnIsDeletable.ClientID%>').value = '';
        document.getElementById('<%=hdnId.ClientID%>').value = 0;
        document.getElementById('<%=btnFinish.ClientID%>').value = slist.Save;
        document.getElementById('<%=lblmsg.ClientID%>').innerHTML = '';
        document.getElementById('<%=hdnStatus.ClientID%>').value = slist.Save;
        //document.getElementById('tdChkDelete').style.display = 'none';


        return false;
    }

    function FoodSessionshowDeleteDiv(id) {
        if (document.getElementById(id).checked) {
            //                document.getElementById('tdbtnDelete').style.display = 'block';
            //                document.getElementById('tdbtnFinish').style.display = 'none';
            document.getElementById('<%=hdnIsDeleted.ClientID%>').value = 'Y';
        }
        else {
            //                document.getElementById('tdbtnDelete').style.display = 'none';
            //                document.getElementById('tdbtnFinish').style.display = 'block';
            document.getElementById('<%=hdnIsDeleted.ClientID%>').value = 'N';
        }
    }

    function FoodSessionFnDelete() {

        if (document.getElementById('<%=hdnId.ClientID%>').value.trim() == 0 || document.getElementById('<%=txtSessionName.ClientID%>').value.trim() == ''
                                                                    || document.getElementById('<%=hdnSessionToBeDel.ClientID%>').value != document.getElementById('<%=txtSessionName.ClientID%>').value) {

            if (document.getElementById('<%=hdnId.ClientID%>').value.trim() == 0 && document.getElementById('<%=txtSessionName.ClientID%>').value.trim() == '') {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodSession.ascx_6');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select the Session to delete');
                    return false;
                }

            } else {
                userMsg = SListForApplicationMessages.Get('CommonControls\\FoodSession.ascx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {

                    alert('Session does not exist');
                    return false;
                }
            }

            return false;
        }

        if (!confirm('Do you wish to delete this Session?')) {

            return false;

        }

        return true;
    }
    function isSpclChar(e) {

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

<style type="text/css">
    .style1
    {
        width: 285px;
    }
    .style2
    {
        width: 124px;
    }
</style>
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
                                <td colspan="10" align="center">
                                    &nbsp;
                                    <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                    <input type="hidden" id="hdnStatus" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbcatgry" runat="server" Text="Session Name" meta:resourcekey="lbcatgryResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSessionName" Width="150px" runat="server" MaxLength="150" CssClass="Txtboxsmall"
                                        OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  meta:resourcekey="txtSessionNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteSession" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                        MinimumPrefixLength="1" ServiceMethod="pGetMasterFoodSessionName" ServicePath="~/NutritionWebService.asmx"
                                        TargetControlID="txtSessionName" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                    <input id="hdnSessionToBeDel" type="hidden" runat="server" />
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
                                    <asp:Label ID="lblValidFrom" Text="Valid From" runat="server" meta:resourcekey="lblValidFromResource1" />
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlFrom" CssClass="ddlmedium" meta:resourcekey="ddlFromResource1"
                                        Height="20px" Width="70px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblValidTo" runat="server" meta:resourcekey="lblValidToResource1"
                                        Text="ValidTo" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTo" runat="server" CssClass="ddlmedium" meta:resourcekey="ddlToResource1"
                                        TabIndex="10" Height="19px" Width="70px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Button ID="btnFinish" runat="server" CssClass="btn" meta:resourcekey="btnFinishResource1"
                                        OnClick="btnFinish_Click" OnClientClick="javascript:return FoodSessioncheckDetails();"
                                        Text=" Save " />
                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource1"
                                        OnClientClick="javascript:return FoodSessionFnClear();" Text=" Clear " />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="100%" id="tblSessionGrid" runat="server" visible="False" class="dataheader2 defaultfontcolor"
                border="0" cellpadding="4" cellspacing="0">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <asp:GridView ID="gvSession" runat="server" AutoGenerateColumns="False" CssClass="mytable1"
                            Width="100%" AllowPaging="True" OnPageIndexChanging="gvSession_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <input id="rdSel" name="radio" onclick="FoodSessionSetValues(this)" value='<%# Eval("FoodSessionID")+"~"+Eval("FoodSessionName")+"~"+ Eval("Description")+"~"+ Eval("FromTime")+"~"+ Eval("ToTime")%>'
                                            type="radio" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SessionName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" Text='<%#Eval("FoodSessionName") %>' runat="server"></asp:Label>
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
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnSessionName" runat="server" />
    <asp:CheckBox ID="chkDelete" runat="server" Visible="False" meta:resourcekey="chkDeleteResource1" />
</div>
