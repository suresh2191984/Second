<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeedbackControl.ascx.cs"
    Inherits="CommonControls_FeedbackControl" %>

<asp:UpdatePanel ID="UdtPanel" runat="server">
    <ContentTemplate>

        <script language="javascript" type="text/javascript">
            function validateFBDetails() {
                if (document.getElementById('<%= ddlFeedBackCat.ClientID %>').value == 0) {
                    //alert('Please Select Category!');
                    document.getElementById('<%= ddlFeedBackCat.ClientID %>').focus();
                    return false;
                }
                if (document.getElementById('<%= txtFBDetails.ClientID %>').value.trim() == '') {
                    alert('Please Enter Details!');
                    document.getElementById('<%= txtFBDetails.ClientID %>').focus();
                    return false;
                }
                //document.getElementById('Footer1_fade').style.display = "none";
                $("#Footer1_fade").hide("slow");
                return true;

            }
        </script>

        <div id="divFeedBack2" style="display: none">
            <table style="background-color: #e0ebf5; border-width: 3px; border-style: solid;
                border-color: Gray; padding: 3px;">
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="a-center font14 bold w-97">
                                    Feedback Form
                                </td>
                                <td class="a-right w-3p">
                                    <img id="imgReplyDivClose" runat="server" src="~/Images/close_button.gif" width="20"
                                        height="20" title="Click to hide Feedback" style="cursor: pointer" onclick="HideDivsFeedBack()" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Label ID="lblmessage" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold paddingL5 paddingR5">
                        Select Category:&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold paddingL5 paddingR5">
                        <asp:DropDownList ID="ddlFeedBackCat" runat="server" Width="300px" CssClass="ddlsmall">
                            <%--<asp:ListItem Text="--Select--" Value="-1" Selected></asp:ListItem>
                                                        <asp:ListItem Text="Suggestion" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Error" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Feedback" Value="3"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold paddingL5 paddingR5">
                        Details:&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center bold paddingL5 paddingR5">
                        <asp:TextBox TextMode="MultiLine" MaxLength="500" onKeyUp="Count(this,500);" onChange="Count(this,500);"
                            ID="txtFBDetails" runat="server" Width="500px" Rows="8"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold paddingL5 paddingR5">
                        Remarks:
                    </td>
                </tr>
                <tr>
                    <td class="a-center bold paddingL5 paddingR5">
                        <asp:TextBox TextMode="MultiLine" MaxLength="500" ID="txtFBRemarks" onKeyUp="Count(this,500);"
                            onChange="Count(this,500);" runat="server" Width="500px" Rows="8"></asp:TextBox>
                    </td>
                    <%--onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"--%>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Button ID="btnFeedBackSubmit" runat="server" Text=" Submit " OnClientClick="javascript:return validateFBDetails();"
                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                            OnClick="btnFeedBackSubmit_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
