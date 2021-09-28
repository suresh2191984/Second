<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeesEntry.ascx.cs" Inherits="CommonControls_FeesEntry" %>
<%@ Register Src="MasterControl.ascx" TagName="MasterControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

    function CheckFees() {


    }
    function IAmSelected(source, eventArgs) {
        document.getElementById('<%= hdnFeeID.ClientID %>').value = eventArgs.get_value().split('^')[0];
    }
    function chkPros() {

        var orgID = '<%= OrgID %>';
        var sval = document.getElementById('<%=ddlFeeType.ClientID %>').options[document.getElementById('<%=ddlFeeType.ClientID %>').selectedIndex].value;
        var sRateID = 0
        var pvalue = "OP";
        var pVisitID = -1;
        var IsMapped;
        var BillPage;
        BillPage = "HOS";
        IsMapped = 'N';
        sval = sval + '~' + orgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + '~' + BillPage;
        $find('<%=AutoCompleteExtender3.ClientID %>').set_contextKey(sval);

    }
    function showModalPopup(evt, footDescID, footAmtID) {
        //evt.preventDefault();
        //document.getElementById('<%= txtFeeDesc.ClientID %>').value = document.getElementById("footDescID").value;
        //document.getElementById('<%= txtAmnt.ClientID %>').value = document.getElementById("footAmtID").value;
        document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
        var modalPopupBehavior = $find('mpeOthersBehavior');
        modalPopupBehavior.show();
    }

    function showPhysician(eltFeeType, trID) {
        if (document.getElementById('<%=ddlFeeType.ClientID %>').options[document.getElementById('<%=ddlFeeType.ClientID %>').selectedIndex].value != "--Select Type--") {
            if (document.getElementById('<%=ddlFeeType.ClientID %>').options[document.getElementById('<%=ddlFeeType.ClientID %>').selectedIndex].value == "CON") {
                if (eltFeeType.value == "CON") {
                    trID.style.display = "block";
                    document.getElementById('<%= trOtherItems.ClientID %>').style.display = "none";
                }

            }
            else {
                document.getElementById('<%= trOtherItems.ClientID %>').style.display = "block";
                document.getElementById('<%= lblOtherItems.ClientID %>').innerHTML = 'Tag To ' + document.getElementById('<%=ddlFeeType.ClientID %>').options[document.getElementById('<%=ddlFeeType.ClientID %>').selectedIndex].text
                trID.style.display = "none";
            }
        }
        else {
            document.getElementById('<%= trOtherItems.ClientID %>').style.display = "none";
            trID.style.display = "none";
        }

    }

    //    function doOnSelectPhysician(source, eventArgs) {
    //        //alert(eventArgs.get_text() + "=>" + eventArgs.get_value());
    //        document.getElementById('<%= hdnFilterPhysicianID.ClientID %>').value = eventArgs.get_value();
    //    }

    function doResetConsultant(sender) {
        sender.value = '';
        sender.readOnly = false;
        document.getElementById('<%= hdnFilterPhysicianID.ClientID %>').value = "0";
    }

    function doValidation() {
        if (document.getElementById("FeesEntry1_txtFeeDesc").value.trim() == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\FeesEntry.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Please Enter Fee Description"); }
            document.getElementById("FeesEntry1_txtFeeDesc").focus();
            return false;
        }

        if (document.getElementById("FeesEntry1_ddlFeeType").value == "--Select Type--") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\FeesEntry.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Choose Fee type");
            }
            document.getElementById("FeesEntry1_ddlFeeType").focus();
            return false;
        } else if (document.getElementById("FeesEntry1_ddlFeeType").value == "CON") {
            if (document.getElementById("FeesEntry1_hdnFilterPhysicianID").value.trim() == "0") {
                if (document.getElementById("FeesEntry1_txtConsultant").value.trim() == "")
                var userMsg = SListForApplicationMessages.Get('CommonControls\\FeesEntry.ascx_3');
                 if (userMsg != null) {
                                 alert(userMsg);
                          }
                    else{("Please Select The Physician To Tag");}
                else
                var userMsg = SListForApplicationMessages.Get('CommonControls\\FeesEntry.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            }else{
                    alert("Entered Physician Name Not Exists");}
                document.getElementById("FeesEntry1_txtConsultant").value = "";
                document.getElementById("FeesEntry1_txtConsultant").readOnly = false;
                document.getElementById("FeesEntry1_txtConsultant").focus();
                return false;
            }
        }

        if (document.getElementById("FeesEntry1_txtAmnt").value.trim() == "" || Number(document.getElementById("FeesEntry1_txtAmnt").value) == 0) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\FeesEntry.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            }else{
            alert("Please Enter Fee Amount");}
            document.getElementById("FeesEntry1_txtAmnt").focus();
            return false;
        }

        return true;
    }

    function doClear() {
        document.getElementById("FeesEntry1_txtFeeDesc").value = "";
        document.getElementById("FeesEntry1_txtAmnt").value = "";
        document.getElementById("FeesEntry1_ddlFeeType").setAttribute("SelectedIndex", "0", "true");
        document.getElementById("FeesEntry1_hdnFilterPhysicianID").value = "0";
        document.getElementById("FeesEntry1_txtConsultant").value = "";
        document.getElementById("FeesEntry1_chkNonReimburse").checked = true;
    }
    
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="defaultfontcolor">
            <input type="hidden" id="hdnCheckStatus" runat="server" />
        </td>
    </tr>
    <tr>
        <td align="center">
            <uc1:MasterControl ID="MasterControl1" Visible="False" runat="server" />
            <asp:Button runat="server" ID="btnSave" Text="Save" OnClientClick="return PopUp()" OnClick="btnSave_Click"
                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                Visible="False" meta:resourcekey="btnSaveResource2" />
            <%--meta:resourcekey="btnSaveResource1"--%>
        </td>
    </tr>
</table>
<asp:GridView ID="gvFeesEntry" runat="server" Width="100%" AutoGenerateColumns="False"
    OnRowDataBound="gvFeesEntry_RowDataBound" OnRowEditing="gvFeesEntry_RowEditing"
    class="defaultfontcolor" OnRowCommand="gvFeesEntry_RowCommand" ShowFooter="True"
    OnSelectedIndexChanged="gvFeesEntry_SelectedIndexChanged" meta:resourcekey="gvFeesEntryResource2">
    <HeaderStyle CssClass="Duecolor" />
    <PagerStyle CssClass="Duecolor1" HorizontalAlign="Left" />
    <Columns>
        <asp:TemplateField HeaderText="Sno" Visible="false" meta:resourcekey="TemplateFieldResource10">
            <ItemTemplate>
                <asp:Label ID="lblSno" runat="server" Text='<%# Bind("SNo") %>' meta:resourcekey="lblSnoResource2"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="select" meta:resourcekey="TemplateFieldResource11">
            <ItemTemplate>
                <asp:CheckBox ID="chkTest" runat="server" onclick="CheckFees()" meta:resourcekey="chkTestResource2" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource12">
            <ItemTemplate>
                <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Descrip") %>' meta:resourcekey="lblDescriptionResource2"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <center>
                    <asp:Label ID="lblOthers" Text="Others" runat="server" meta:resourcekey="lblOthersResource2"></asp:Label>
                </center>
            </FooterTemplate>
            <%--<FooterTemplate>
                <asp:TextBox ID="txtFooterDescription" runat='server' Text=''></asp:TextBox>
            </FooterTemplate>--%>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource13">
            <ItemTemplate>
                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' meta:resourcekey="txtAmountResource2"></asp:TextBox>
            </ItemTemplate>
            <FooterTemplate>
                <center>
                    <input id="btnAdd" type="button" class="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" value="Add" onclick="showModalPopup(event);" />
                </center>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="false" Visible="false" meta:resourcekey="TemplateFieldResource14">
            <ItemTemplate>
                <asp:Label ID="lblisVariable" runat="server" Text='<%# Bind("IsVariable") %>' meta:resourcekey="lblisVariableResource2"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="false" Visible="false" meta:resourcekey="TemplateFieldResource15">
            <ItemTemplate>
                <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>' meta:resourcekey="lblIDResource2"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="false" Visible="false" meta:resourcekey="TemplateFieldResource16">
            <ItemTemplate>
                <asp:Label ID="lblisGroup" runat="server" Text='<%# Bind("IsGroup") %>' meta:resourcekey="lblisGroupResource2"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="false" Visible="false" meta:resourcekey="TemplateFieldResource17">
            <ItemTemplate>
                <asp:Label ID="lblFeeType" runat="server" Text='<%# Bind("FeeType") %>' meta:resourcekey="lblFeeTypeResource3"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="IsReImbursable" meta:resourcekey="TemplateFieldResource18">
            <ItemTemplate>
                <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" meta:resourcekey="chkIsReImbursableItemResource3" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup"
    meta:resourcekey="pnlOthersResource2">
    <center>
        <div id="divOthers" style="width: 350px; height: 200px; padding-top: 50px; padding-left: 15px">
            <table width="90%" align="center">
                <tr align="left">
                    <td>
                        <asp:Label ID="lblFeeDesc" Width="155px" runat="server" Text="Fee Description" meta:resourcekey="lblFeeDescResource2"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFeeDesc" runat="server" meta:resourcekey="txtFeeDescResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <asp:Label ID="lblFeeType" Width="155px" runat="server" Text="Tag To" meta:resourcekey="lblFeeTypeResource4"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlFeeType" Width="155px" runat="server" onchange="javascript:showPhysician(this,getElementById('trPhysician'));"
                            meta:resourcekey="ddlFeeTypeResource2">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="trPhysician" style="display: none" align="left">
                    <td>
                        <asp:Label ID="lblPhysician" Width="155px" runat="server" Text="Tag To Physician"
                            meta:resourcekey="lblPhysicianResource2"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtConsultant" onclick="javascript:doResetConsultant(this);" onblur="this.readOnly=true;"
                            runat="server" meta:resourcekey="txtConsultantResource2"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteConsultant" runat="server" CompletionInterval="1"
                            CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                            CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                            UseContextKey="True" MinimumPrefixLength="2" OnClientItemSelected="doOnSelectPhysician"
                            ServiceMethod="GetConsultantName" ServicePath="~/WebService.asmx" TargetControlID="txtConsultant"
                            DelimiterCharacters="" Enabled="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr id="trOtherItems" runat="server" style="display: none;" align="left">
                    <td>
                        <asp:Label ID="lblOtherItems" Width="155px" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox onclick="javascript:doResetConsultant(this);" ID="txtName" onfocus="chkPros();"
                            onblur="this.readOnly=true;" runat="server"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtName"
                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                            OnClientItemSelected="IAmSelected" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            ServiceMethod="GetQuickBillItems" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                            DelimiterCharacters="" Enabled="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <asp:Label ID="lblAmount" Width="155px" runat="server" Text="Fee Amount" meta:resourcekey="lblAmountResource2"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmnt" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                            onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);" meta:resourcekey="txtAmntResource2"></asp:TextBox>
                    </td>
                </tr>
                <tr align="left">
                    <td colspan="2">
                        <asp:CheckBox ID="chkNonReimburse" runat="server" Checked="True" Text="Is This Reimbursable Item."
                            meta:resourcekey="chkNonReimburseResource2" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Button ID="btnOK" CssClass="btn" runat="server" Text="OK" OnClientClick="javascript:return doValidation();"
                            OnClick="btnAdd_Click" meta:resourcekey="btnOKResource2" />
                    </td>
                    <td align="left">
                        <input type="button" id="btnCancel" class="btn" onclick="javascript:doClear();" runat="server"
                            value="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
    </center>
</asp:Panel>
<%--<asp:Button ID="hiddenTargetControlFormpeOthers" runat="server" Style="display: none" />--%>
<asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
<ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
    PopupControlID="pnlOthers" CancelControlID="btnCancel" TargetControlID="hiddenTargetControlFormpeOthers"
    DynamicServicePath="" Enabled="True">
</ajc:ModalPopupExtender>
<asp:HiddenField ID="hdnAmount" runat="server" />
<asp:HiddenField ID="hdnProAmount" runat="server" />
<asp:HiddenField ID="hdnFilterPhysicianID" runat="server" Value="0" />
<asp:HiddenField ID="hdnFeeID" runat="server" Value="0" />

<script language="javascript" type="text/javascript">
    function doOnSelectPhysician(source, eventArgs) {
        //  alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
        // eventArgs.get_value()[0].PatientID;
        //        var list = eventArgs.get_value().split('^');
        //        if (list.length > 0) {
        //            for (i = 0; i < list.length; i++) {
        //                if (list[i] != "") {
        //                    var phyFeeId = list[0];
        //                    var phyName = list[1];
        //                    var feeType = list[2];
        //                    var amount = list[3];
        //                    var physicianLID = list[4];
        //                    var specialityID = list[5];

        //                    document.getElementById('FeesEntry1_txtAmnt').value = amount;
        //                    document.getElementById('FeesEntry1_hdnFilterPhysicianID').value = phyFeeId;

        //                }
        //            }
        //        }

        document.getElementById('FeesEntry1_hdnFilterPhysicianID').value = eventArgs.get_value();
    }

</script>

