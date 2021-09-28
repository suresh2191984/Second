<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeedbackControl.ascx.cs" 
Inherits="PlatFormControls_FeedbackControl" %>

<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>
        <script language="javascript" type="text/javascript">
            function validateFBDetails() {
                if (document.getElementById('<%= ddlFeedBackCat.ClientID %>').value == 0) {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_FeedbackControl_ascx_01');
                    var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                    if (ErrorMsg == null) {
                        ErrorMsg = "Error";
                    }
                    if (userMsg != null) {
                        ValidationWindow(userMsg, ErrorMsg);
                    }
                    else {
                        ValidationWindow('Please Select Category!', 'Error');
                    }
                    document.getElementById('<%= ddlFeedBackCat.ClientID %>').focus();
                    return false;
                }
                if (document.getElementById('<%= txtFBDetails.ClientID %>').value.trim() == '') {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_FeedbackControl_ascx_02');
                    var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                    if (ErrorMsg == null) {
                        ErrorMsg = "Error";
                    }
                    if (userMsg != null) {
                        ValidationWindow(userMsg, ErrorMsg);
                    }
                    else {
                        ValidationWindow('Please Enter Details!', 'Error');
                    }
                    document.getElementById('<%= txtFBDetails.ClientID %>').focus();
                    return false;
                }
               // document.getElementById('Attunefooter_fade').style.display = "none";
                return true;

            }
        </script>

        <div id="divFeedBack2" style="display: none">
            <table style="background-color: #e0ebf5; border-width: 3px; border-style: solid;
                border-color: Gray; padding: 3px;" cellpadding="0">
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="a-center" style="font-size: 14px; font-weight: bold; width: 97%;">
                                    <asp:Label ID="lblFeedBackForm" runat="server" Text="Feedback Form" 
                                        meta:resourcekey="lblFeedBackFormResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right" style="width: 3%;">
                                    <img id="imgReplyDivClose" runat="server" src="~/PlatForm/Images/close_button.gif" width="20"
                                        height="20" title="Click to hide Feedback" style="cursor: pointer" onclick="HideDivsFeedBack()" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Label ID="lblmessage" runat="server" 
                            meta:resourcekey="lblmessageResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" style="font-weight: bold; padding-left: 5px; padding-right: 5px;line-height:25px;">
                        <asp:Label ID="lblSelectCategory" runat="server" Text="Select Category:" meta:resourcekey="lblSelectCategory"></asp:Label>
                        <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                    </td>
                </tr>
                <tr>
                    <td class="a-left" style="padding-left: 5px; padding-right: 5px;">
                        <asp:DropDownList ID="ddlFeedBackCat" runat="server" CssClass="small"
						meta:resourcekey="ddlFeedBackCatResource1">
                            <%--<asp:ListItem Text="--Select--" Value="-1" Selected></asp:ListItem>
                                                        <asp:ListItem Text="Suggestion" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Error" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Feedback" Value="3"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" style="font-weight: bold; padding-left: 5px; padding-right: 5px;line-height:25px;">
                        <asp:Label ID="lblDetails" runat="server" Text="Details:" meta:resourcekey="lblDetails"></asp:Label>
                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center" style="padding-left: 5px; padding-right: 5px;">
                        <asp:TextBox TextMode="MultiLine" MaxLength="500" onKeyUp="Count(this,500);" onChange="Count(this,500);"
                            ID="txtFBDetails" runat="server" Width="500px" CssClass="feedTxtArea" onkeypress="return ValidateMultiLangChar(this);"
                            Rows="8" meta:resourcekey="txtFBDetailsResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" style="font-weight: bold; padding-left: 5px; padding-right: 5px;line-height:25px;">
                        <asp:Label ID="lblRemarks" runat="server" Text=" Remarks:" meta:resourcekey="lblRemarks"></asp:Label>
                       
                    </td>
                </tr>
                <tr>
                    <td class="a-center" style="padding-left: 5px; padding-right: 5px;">
                        <asp:TextBox TextMode="MultiLine" MaxLength="500" ID="txtFBRemarks" onKeyUp="Count(this,500);"
                            onChange="Count(this,500);" runat="server" Width="500px" onkeypress="return ValidateMultiLangChar(this);"
                            CssClass="feedTxtArea" Rows="8" meta:resourcekey="txtFBRemarksResource1"></asp:TextBox>
                    </td>
                    <%--onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"--%>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Button ID="btnFeedBackSubmit" runat="server" Text=" Submit " OnClientClick="javascript:return validateFBDetails();"
                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                            OnClick="btnFeedBackSubmit_Click" 
                            meta:resourcekey="btnFeedBackSubmitResource1" />
                    </td>
                </tr>
            </table>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
