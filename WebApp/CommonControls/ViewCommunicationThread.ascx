<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewCommunicationThread.ascx.cs"
    Inherits="CommonControls_ViewCommunicationThread" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>--%>

<script language="javascript" type="text/javascript">
    var oldgridcolor;
    function SetMouseOver(element) {
        oldgridcolor = element.style.backgroundColor;
        element.style.backgroundColor = '#F0F0F0';
    }
    function SetMouseOut(element) {
        element.style.backgroundColor = oldgridcolor;
        element.style.textDecoration = 'none';
    }
    function showReplydiv() {
        document.getElementById('<%=divReply.ClientID %>').style.display = "block";
    }
    function hideReplydiv() {
        document.getElementById('<%=divReply.ClientID %>').style.display = "none";
    }
    function chkAcknowledge() {
        var InformationMsg;
        var Error;
        Error = SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_002") != null ? SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_002") : "Information";
        InformationMsg = SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_001") != null ? SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_001") : "Please provide your acknowledgement by checking - I have read this message.";
        

        if (document.getElementById('<%=rdoACK.ClientID %>').checked == false) {
            ValidationWindow(InformationMsg + '  ' + length, Error);

           // alert('Please provide your acknowledgement by checking - I have read this message.');
            return false;
        }
    }
   
</script>

<script type="text/javascript">
    var InformationMsg1;
    var Error; 
    function GetVistDetails() {
        Error = SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_002") != null ? SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_002") : "Information";
               
        var VisitNum = $('#<%=hdnVisitNum.ClientID %>').val();
        if (VisitNum.trim() != '') {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetVisitNumber",
                data: "{ 'VisitNumber': '" + VisitNum + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {

                var Items = data.d;
                InformationMsg1 = SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_003") != null ? SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_003") : "Please enter correct visit number";
        
                    if (Items.length == 0) {
                        $('#trVisitDetails').html("");
                        ValidationWindow(InformationMsg1 + '  ' + length, Error);

                      //  alert("Please enter correct visit number")
                    }
                    else {
                        BindFoodList(Items);
                    }
                },
                failure: function(msg) {

                var InformationMsg2 = SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_004") != null ? SListForAppMsg.Get("CommonControls_ViewCommunicationThread_ascx_004") : "error";

                ValidationWindow(InformationMsg2 + '  ' + length, Error);

                    //alert('error');
                }
            });
        }
    }
    function BindFoodList(Items) {

        $.each(Items, function(index, Item) {
            var tblrow = "<td colspan='3'><table width='300px' id='tblborder'><tr><th>Name</th><th>Age</th><th>Gender</th></tr><tr><td>" + Item.Name + "</td><td>" + Item.Age + "</td><td>" + Item.Gender + "</td></tr></table></td>"
            $('#trVisitDetails').html(tblrow);
        });
    }

</script>

<style>
    #tblborder
    {
        border-collapse: collapse;
    }
    #tblborder td
    {
        border: 1px solid black;
        text-align: left;
        height: 20px;
        padding-left: 5px;
    }
    #tblborder th
    {
        border: 1px solid black;
        text-align: center;
        font-weight: bold;
        height: 20px;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:HiddenField ID="hdnVisitNum" runat="server" />
        <table cellpadding="2" class="w-100p" runat="server" id="tblDisplay" style="display: none"
            runat="server">
            <tr>
                <td>
                    <asp:Label ID="CommunciationNote" runat="server" Font-Bold="False" Text="Note: <br/>1. Communication Message(s) viewed here will be treated as readed only by Clicking OK. So, Please go through the Message(s) clearly and Click OK.<br/>2. Notice(s) that are mandatory to Acknowledge will be treated as Unread, until the Acknowledgement has been provided."
                        meta:resourcekey="CommunciationNoteResource1"></asp:Label><br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnBack" runat="server" Text=" Back " CssClass="btnCompose" Style="cursor: pointer"
                        OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />&nbsp;
                    <asp:Label ID="lblShowMessage" runat="server" CssClass="font11" Font-Bold="True"
                        ForeColor="Green" meta:resourcekey="lblShowMessageResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="ViewCommunication" runat="server">
                        <asp:GridView ID="grdViewDetailCommunication" runat="server" AutoGenerateColumns="False"
                            BackColor="LightGray" BorderColor="#FFFFFF" ClientIDMode="Static" DataKeyNames="CommID, CommType, RoleID, LoginID"
                            EmptyDataText="No Communication found" Font-Names="verdana" Font-Size="8pt" GridLines="None"
                            Height="12%" OnRowCommand="grdViewDetailCommunication_RowCommand" OnRowDataBound="grdViewDetailCommunication_RowDataBound"
                            PagerStyle-ForeColor="black" PageSize="20" CssClass="w-100p gridView" meta:resourcekey="grdViewDetailCommunicationResource1">
                            <RowStyle BorderColor="#88C0DE" BorderWidth="1px" ForeColor="#000066" CssClass="h-28 v-middle" />
                            <Columns>
                                <asp:TemplateField HeaderStyle-BackColor="#2c88b1" HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="White"
                                    HeaderStyle-HorizontalAlign="Left" HeaderText="From" ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBroadCastedBy" runat="server" ForeColor="Black" Text='<%# Bind("BroadcastedBy") %>'
                                            meta:resourcekey="lblBroadCastedByResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="w-18p" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-BackColor="#2c88b1" HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="White"
                                    HeaderStyle-HorizontalAlign="Left" HeaderText="To" ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblToName" runat="server" ForeColor="Black" Text='<%# Bind("ToName") %>'
                                            meta:resourcekey="lblToNameResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-BackColor="#2c88b1" HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="White"
                                    HeaderStyle-HorizontalAlign="Left" HeaderText=" " ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTypeIndicator" runat="server" ForeColor="Black" Text=" " meta:resourcekey="lblTypeIndicatorResource1"></asp:Label>
                                        <asp:Image ID="ImgMsgStore" runat="server" CssClass="w-20 h-20" meta:resourcekey="ImgMsgStoreResource1" />
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="Maroon" HeaderStyle-HorizontalAlign="Left"
                                    HeaderText="ACKStatus" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblACKStatus" runat="server" ForeColor="Black" Text='<%# Bind("CommCategoryID") %>'
                                            meta:resourcekey="lblACKStatusResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="Maroon" HeaderStyle-HorizontalAlign="Left"
                                    HeaderText="RoleID" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleID" runat="server" ForeColor="Black" Text='<%# Bind("RoleID") %>'
                                            meta:resourcekey="lblRoleIDResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Left"
                                    HeaderText="LoginID" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLoginID" runat="server" ForeColor="Black" Text='<%# Bind("LoginID") %>'
                                            meta:resourcekey="lblLoginIDResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-BackColor="#2c88b1" HeaderStyle-Font-Size="8pt" HeaderStyle-ForeColor="White"
                                    HeaderStyle-HorizontalAlign="Left" HeaderText="Message(s)" ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1" Visible="True">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkCommContent" runat="server" CommandArgument="<%# Container.DataItemIndex %>"
                                            CommandName="View" ForeColor="Black" Text='<%# Bind("CommContent") %>' meta:resourcekey="lnkCommContentResource1"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CommID" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommID" runat="server" ForeColor="Black" Text='<%# Bind("CommID") %>'
                                            meta:resourcekey="lblCommIDResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CommType" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommType" runat="server" ForeColor="Black" Text='<%# Bind("CommType") %>'
                                            meta:resourcekey="lblCommTypeResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CommCode" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1"
                                    Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommCode" runat="server" ForeColor="Black" Text='<%# Bind("CommCode") %>'
                                            meta:resourcekey="lblCommCodeResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="dataheader1 w-14 a-center v-middle" ForeColor="Black" />
                            <HeaderStyle BackColor="#D7D7D7" CssClass="dataheader1 h-28 a-left w-14" ForeColor="Black" />
                        </asp:GridView>
                    </div>
                    <table>
                    </table>
                    <div id="NoticeBoard" runat="server" class="contentdata1" style="display: block;">
                        <table cellpadding="4" class="w-71p">
                            <tr id="trNoticeBoard" runat="server">
                                <td style="background-color: #ffffff;">
                                    <table cellpadding="4" class="w-100p">
                                        <tr>
                                            <td class="w-30p">
                                                <asp:Label ID="lblNBCode" runat="server" Font-Bold="True" ForeColor="Green" meta:resourcekey="lblNBCodeResource1"></asp:Label>
                                            </td>
                                            <td class="a-right w-70p">
                                                <asp:Label ID="lblNote" runat="server" Font-Bold="False" ForeColor="DarkBlue" Text="* Please acknowledge after reading."
                                                    meta:resourcekey="lblNoteResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblSubject" runat="server" Font-Bold="True" ForeColor="Black" meta:resourcekey="lblSubjectResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table cellpadding="4" class="w-100p">
                                        <tr>
                                            <td style="background-color: #d7d7d7;">
                                                <table cellpadding="4" class="w-100p">
                                                    <tr>
                                                        <td class="w-75p">
                                                            <asp:Label ID="lblNBMsgFrom" runat="server" Font-Bold="True" ForeColor="Maroon" meta:resourcekey="lblNBMsgFromResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-25p" style="font-size: x-small;">
                                                            <asp:Label ID="lblNBSenton" runat="server" Font-Bold="True" ForeColor="Maroon" meta:resourcekey="lblNBSentonResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <hr />
                                                <table cellpadding="4" class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblMessagelabel" runat="server" Font-Bold="True" Font-Size="11px"
                                                                ForeColor="Maroon" Text="Message:" meta:resourcekey="lblMessagelabelResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table cellpadding="4" class="w-100p">
                                        <tr id="trACKOption" runat="server">
                                            <td>
                                                <table cellpadding="4" class="w-100p">
                                                    <tr>
                                                        <td class="w-70p">
                                                            <asp:RadioButton ID="rdoACK" runat="server" Text="Yes, I have read this message."
                                                                meta:resourcekey="rdoACKResource1" />
                                                        </td>
                                                        <td class="w-30p v-middle">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trRemarks" runat="server">
                                            <td>
                                                <table cellpadding="4" class="w-100p">
                                                    <tr>
                                                        <td class="w-10p">
                                                            <asp:Label ID="Label3" runat="server" ForeColor="Black" Text="Remarks:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                        </td>
                                                        <td class="w-90p">
                                                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="small"
                                                                meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnAck" runat="server" CssClass="btn" OnClick="btnAck_Click" OnClientClick="javascript:return chkAcknowledge();"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text=" Acknowledge "
                                                    Visible="False" meta:resourcekey="btnAckResource1" />
                                                <asp:Button ID="btnNBOK" runat="server" CssClass="btn" OnClick="btnNBOK_Click" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text=" OK " Visible="False" meta:resourcekey="btnNBOKResource1" />
                                                <asp:Button ID="btnNBCancel" runat="server" CssClass="btn" OnClick="btnNBCancel_Click"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text=" Cancel "
                                                    meta:resourcekey="btnNBCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="NewCommunication" runat="server" class="contentdata1" style="display: block;">
                        <table cellpadding="4" class="w-71p">
                            <tr id="trNewCommunication" runat="server">
                                <td style="background-color: #ffffff;">
                                    <table cellpadding="4" class="w-100p" id="tdNewCommunication" runat="server">
                                        <tr>
                                            <td class="w-80p">
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Black" meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td class="w-20p v-middle">
                                                <asp:Button ID="btnOk" runat="server" CssClass="btn" OnClick="btnOk_Click" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text=" OK " meta:resourcekey="btnOkResource1" />
                                                <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text=" Cancel "
                                                    meta:resourcekey="btnCancelResource1" />
                                                <img id="imgReply" runat="server" class="v-middle h-25 w-25" alt="show" onclick="javascript:showReplydiv();"
                                                    src="../Images/messagereply.png" style="cursor: pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table id="tblVisitdetails" runat="server" visible="false">
                                        <tr class="bold">
                                            <td>
                                                <%=Resources.CommonControls_AppMsg.CommonControls_ViewCommunicationThread_ascx_005%> 

                                                <asp:Label ID="lblVisitNum" runat="server" meta:resourcekey="lblVisitNumResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="trVisitDetails">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="4" class="w-100p">
                                        <tr>
                                            <td style="background-color: #d7d7d7;">
                                                <table class="w-100p" cellpadding="4">
                                                    <tr>
                                                        <td class="w-75p">
                                                            <asp:Label ID="lblCommMsgFrom" runat="server" Font-Bold="True" ForeColor="Maroon"
                                                                meta:resourcekey="lblCommMsgFromResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-25p" style="font-size: x-small;">
                                                            <asp:Label ID="lblSentOn" runat="server" Font-Bold="True" ForeColor="Maroon" meta:resourcekey="lblSentOnResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <hr />
                                                <table cellpadding="4" class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label4" runat="server" Font-Bold="True" CssClass="font11" ForeColor="Maroon"
                                                                Text="Message:" meta:resourcekey="Label4Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <div id="divReply" runat="server" style="display: none;">
                            <table cellpadding="4" class="dataheader3 w-70p">
                                <tr>
                                    <td>
                                        <table cellpadding="4" class="w-100p">
                                            <tr>
                                                <td class="w-97p">
                                                    <asp:Button ID="btnReply" runat="server" CssClass="btn" OnClick="btnReply_Click"
                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text=" Send "
                                                        meta:resourcekey="btnReplyResource1" />
                                                </td>
                                                <td class="w-3p">
                                                    <img id="imgReplyDivClose" runat="server" class="v-middle h-20 w-20" alt="show" onclick="javascript:hideReplydiv();"
                                                        src="../Images/close_button.gif" style="cursor: pointer" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server" Height="200px" Width="750px">
                                        </FCKeditorV2:FCKeditor>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="display: none;">
                                        <asp:Panel ID="Panel3" runat="server" GroupingText="Send To" CssClass="w-100p" meta:resourcekey="Panel3Resource1">
                                            <asp:CheckBox ID="chkCheckAll" runat="server" Font-Bold="True" onclick="checkAllItem(this);"
                                                Text="Select all" meta:resourcekey="chkCheckAllResource1" />
                                            <asp:CheckBoxList ID="chkUsers" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                                meta:resourcekey="chkUsersResource1">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table cellpadding="4" class="w-70p" style="display: none;">
                                            <tr>
                                                <td class="style2">
                                                    <asp:Label ID="lblValidity" runat="server" CssClass="a-left" Text="Expires on &lt;br&gt;[Valid Till To Display]:"
                                                        meta:resourcekey="lblValidityResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass="small" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                        PopupButtonID="ImgFDate" TargetControlID="txtFDate" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="ImgFDateResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblParentCommID" runat="server" Visible="False" meta:resourcekey="lblParentCommIDResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                   <%-- <uc5:errordisplay id="ErrorDisplay1" runat="server" />--%>
                </td>
            </tr>
            </caption>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
