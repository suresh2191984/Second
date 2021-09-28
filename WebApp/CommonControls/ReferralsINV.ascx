<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferralsINV.ascx.cs"
    Inherits="CommonControls_ReferralsINV" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">

    function showModalPopup(evt, footDescID, footAmtID) {
        //evt.preventDefault();
        //document.getElementById('<%= txtFeeDesc.ClientID %>').value = document.getElementById("footDescID").value;
        //document.getElementById('<%= txtAmnt.ClientID %>').value = document.getElementById("footAmtID").value;
        document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
        var modalPopupBehavior = $find('mpeOthersBehavior');
        modalPopupBehavior.show();
    }

    function showPhysician(eltFeeType, trID) {
        if (eltFeeType.value == "CON")
            trID.style.display = "block";
        else
            trID.style.display = "none";

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
        if (document.getElementById("ReferralsINV1_txtFeeDesc").value.trim() == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReferralsINV.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Enter Fee Description");
            }
            document.getElementById("ReferralsINV1_txtFeeDesc").focus();
            return false;
        }

        if (document.getElementById("ReferralsINV1_ddlFeeType").value == "--Select Type--") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReferralsINV.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Choose Fee type");
            }
            document.getElementById("ReferralsINV1_ddlFeeType").focus();
            return false;
        } else if (document.getElementById("ReferralsINV1_ddlFeeType").value == "CON") {
            if (document.getElementById("ReferralsINV1_hdnFilterPhysicianID").value.trim() == "0") {
                if (document.getElementById("ReferralsINV1_txtConsultant").value.trim() == "")
                var userMsg = SListForApplicationMessages.Get('CommonControls\\ReferralsINV.ascx_3');
                 if (userMsg != null) {
                      alert(userMsg);
                    } else{
                    alert("Please Select The Physician To Tag");}
                else
                    alert("Entered Physician Name Not Exists");
                document.getElementById("ReferralsINV1_txtConsultant").value = "";
                document.getElementById("ReferralsINV1_txtConsultant").readOnly = false;
                document.getElementById("ReferralsINV1_txtConsultant").focus();
                return false;
            }
        }

        if (document.getElementById("ReferralsINV1_txtAmnt").value.trim() == "" || Number(document.getElementById("ReferralsINV1_txtAmnt").value) == 0) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReferralsINV.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            } else{
            alert("Please Enter Fee Amount");}
            document.getElementById("ReferralsINV1_txtAmnt").focus();
            return false;
        }

        return true;
    }

    function doClear() {
        document.getElementById("ReferralsINV1_txtFeeDesc").value = "";
        document.getElementById("ReferralsINV1_txtAmnt").value = "";
        document.getElementById("ReferralsINV1_ddlFeeType").setAttribute("SelectedIndex", "0", "true");
        document.getElementById("ReferralsINV1_hdnFilterPhysicianID").value = "0";
        document.getElementById("ReferralsINV1_txtConsultant").value = "";
        document.getElementById("ReferralsINV1_chkNonReimburse").checked = true;
    }
    
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table border="0" cellpadding="2" cellspacing="1" width="100%">
            <tr>
                <td>
                    <asp:GridView ID="gvInvestigations" runat="server" Width="90%" AutoGenerateColumns="False"
                        class="defaultfontcolor" ShowFooter="True" OnRowDataBound="gvInvestigations_RowDataBound"
                        meta:resourcekey="gvInvestigationsResource1">
                        <HeaderStyle CssClass="Duecolor" />
                        <PagerStyle CssClass="Duecolor1" HorizontalAlign="Left" />
                        <Columns>
                            <asp:TemplateField HeaderText="select" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:CheckBox Checked="True" ID="chkTest" runat="server" />
                                    <%--meta:resourcekey="chkTestResource1"--%>
                                    <asp:HiddenField ID="hdnSno" runat="server" Value='<%# Bind("ProcedureType") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="hdnisVariable" runat="server" Value='<%# Bind("IsVariable") %>'>
                                    </asp:HiddenField>
                                    <asp:HiddenField ID="hdnID" runat="server" Value='<%# Bind("ID") %>'></asp:HiddenField>
                                    <asp:HiddenField ID="hdnisGroup" runat="server" Value='<%# Bind("IsGroup") %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Descrip") %>'> 
                                        <%--meta:resourcekey="lblDescriptionResource1"--%></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <center>
                                        <asp:Label ID="lblOthers" Text="Others" runat="server" meta:resourcekey="lblOthersResource1"></asp:Label>
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAmount" runat="server" Width="70px" Text='<%# Bind("Amount") %>'> <%--meta:resourcekey="txtAmountResource1"--%></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <center>
                                        <input id="btnAdd" type="button" class="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" value="Add" onclick="showModalPopup(event);" />
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Performing Org" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlPerformingOrg" runat="server">
                                        <%--meta:resourcekey="ddlPerformingOrgResource1"--%>
                                    </asp:DropDownList>
                                    <asp:Image ImageUrl="../Images/starbutton.png" Visible="False" ID="imgPaid" runat="server" />
                                    <%--meta:resourcekey="imgPaidResource1"--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsReImbursable" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" />
                                    <%--meta:resourcekey="chkIsReImbursableItemResource1"--%>
                                    <asp:HiddenField ID="hdnFeeType" runat="server" Value='<%# Bind("FeeType") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup"
            meta:resourcekey="pnlOthersResource1">
            <center>
                <div id="divOthers" style="width: 350px; height: 200px; padding-top: 50px; padding-left: 15px">
                    <table width="90%" align="center">
                        <tr align="left">
                            <td>
                                <asp:Label ID="lblFeeDesc" Style="width: 155px;" runat="server" Text="Fee Description"
                                    meta:resourcekey="lblFeeDescResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFeeDesc" runat="server" meta:resourcekey="txtFeeDescResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <asp:Label ID="lblFeeType" runat="server" Text="Tag To" meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFeeType" Width="155px" runat="server" onchange="javascript:showPhysician(this,getElementById('trPhysician'));"
                                    meta:resourcekey="ddlFeeTypeResource1">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPhysician" style="display: none" align="left">
                            <td>
                                <label id="lblPhysician" style="width: 155px;">
                                    <asp:Label ID="Rs_TagToPhysician" runat="server" Text="Tag To Physician" meta:resourcekey="Rs_TagToPhysicianResource1"></asp:Label>
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConsultant" onclick="javascript:doResetConsultant(this);" onblur="this.readOnly=true;"
                                    runat="server" meta:resourcekey="txtConsultantResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteConsultant" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                    UseContextKey="True" MinimumPrefixLength="2"  
                                    ServiceMethod="GetConsultantName" ServicePath="~/WebService.asmx" TargetControlID="txtConsultant"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <asp:Label ID="lblAmount" runat="server" Text="Fee Amount" meta:resourcekey="lblAmountResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAmnt" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);" meta:resourcekey="txtAmntResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td colspan="2">
                                <asp:CheckBox ID="chkNonReimburse" runat="server" Checked="True" Text="Is This Reimbursable Item."
                                    meta:resourcekey="chkNonReimburseResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnOK" CssClass="btn" runat="server" Text="OK" OnClientClick="javascript:return doValidation();"
                                    OnClick="btnAdd_Click" meta:resourcekey="btnOKResource1" />
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
        <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
        <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
            PopupControlID="pnlOthers" CancelControlID="btnCancel" TargetControlID="hiddenTargetControlFormpeOthers"
            DynamicServicePath="" Enabled="True">
        </ajc:ModalPopupExtender>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:HiddenField ID="hdnFilterPhysicianID" runat="server" Value="0" />

<script language="javascript" type="text/javascript">
    function doOnSelectPhysician(source, eventArgs) {
        // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
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

        //                    document.getElementById('ReferralsINV1_txtAmnt').value = amount;
        //                    document.getElementById('ReferralsINV1_hdnFilterPhysicianID').value = phyFeeId;

        //                }
        //            }
        //        }
        document.getElementById('ReferralsINV1_hdnFilterPhysicianID').value = eventArgs.get_value();
    }

</script>

