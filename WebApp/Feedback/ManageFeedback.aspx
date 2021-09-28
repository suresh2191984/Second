<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageFeedback.aspx.cs" Inherits="Feedback_ManageFeedback"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Feedback</title>
</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnUpdate">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel7" CssClass="searchPanel" BorderWidth="1px" runat="server" meta:resourcekey="Panel7Resource1">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <table class="w-50p">
                                                <tr>
                                                    <td class="a-left">
                                                     <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_01%>   
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFeedBackCat" runat="server" CssClass="small" 
                                                            >
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="a-right">
                                                        <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_02%>   
                                                    </td>
                                                    <td class="w-35p">
                                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="small" 
                                                            >
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Search Posted Feedback"
                                                            OnClick="btnSearch_Click" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            OnClientClick="javascript:return validate();" onmouseout="this.className='btn'"
                                                            meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblStatus" runat="server" ForeColor="#000333" meta:resourcekey="lblStatusResource1"
                                Text="No Matching Records Found!" Visible="False"></asp:Label>
                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="4" CssClass="gridView w-100p" DataKeyNames="ID,Status,Module,PageURL,Description,Remarks,Priority"
                                meta:resourcekey="grdResultResource1" OnPageIndexChanging="grdResult_PageIndexChanging"
                                OnRowCommand="grdResult_RowCommand" OnRowDataBound="grdResult_RowDataBound">
                                <PagerTemplate>
                                    <tr>
                                        <td class="a-center" colspan="6">
                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png"  
                                                Width="18px" meta:resourcekey="lnkPrevResource2" />
                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png"  
                                                Width="18px" meta:resourcekey="lnkNextResource2" />
                                        </td>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle CssClass="gridHeader" />
                                <RowStyle Font-Bold="False" />
                                <PagerSettings Mode="NextPrevious" />
                                <PagerStyle CssClass="gridPager" />
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID"  
                                        Visible="False" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField DataField="Module" HeaderText="Module" 
                                        meta:resourcekey="BoundFieldResource4" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PageURL" HeaderText="PageURL" 
                                        meta:resourcekey="BoundFieldResource5" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" 
                                        meta:resourcekey="BoundFieldResource6" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                                        meta:resourcekey="BoundFieldResource7" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Status" HeaderText="Status" 
                                        meta:resourcekey="BoundFieldResource8" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" id="hdnPrincipleID" runat="server" >
                                <table id="tblUpdate" runat="server" class="w-50p searchPanel">
                                    <tr runat="server">
                                        <td runat="server">
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_03%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:Label ID="lblModule" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_04%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:Label ID="lblPgeURL" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_05%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:Label ID="lblPriority" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_06%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:TextBox ID="txtFBDesc" runat="server" MaxLength="500" ReadOnly="True" 
                                                Rows="8" Style="height: 40px; width: 200px;" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_07%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:DropDownList ID="ddlChangeStatus" runat="server" CssClass="small">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" class="a-left" style="padding: 10px;">
                                            <%=Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_08%>
                                        </td>
                                        <td runat="server" class="a-left">
                                            <asp:TextBox ID="txtFBRemarks" runat="server" MaxLength="500" 
                                                onChange="Count(this,500);" onKeyUp="Count(this,500);" Rows="8" 
                                                TextMode="MultiLine" Width="500px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">
                                        </td>
                                    </tr>
                                </table>
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn" meta:resourcekey="btnUpdateResource1"
                                OnClick="btnUpdate_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                Style="cursor: pointer;" Text="Save Changes" ToolTip="Click here to Change Principle Details"
                                Visible="False" />
                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource1"
                                OnClick="btnCancel_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                Style="cursor: pointer;" Text="Cancel" ToolTip="Click here to Cancel" Visible="False" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
    var errorMsg;
    var informMsg;
    var okMsg;
    var cancelMsg;
 
    $(document).ready(function() {      
        errorMsg = SListForAppMsg.Get('Feedback_Error') == null ? "Alert" : SListForAppMsg.Get('Feedback_Error');
        informMsg = SListForAppMsg.Get('Feedback_Information') == null ? "Information" : SListForAppMsg.Get('Feedback_Information');
        okMsg = SListForAppMsg.Get('Feedback_Ok') == null ? "Ok" : SListForAppMsg.Get('Feedback_Ok')
        cancelMsg = SListForAppMsg.Get('Feedback_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Feedback_Cancel');
    });
</script>
<script language="javascript" type="text/javascript">
    function validate() {
        // alert(document.getElementById('ddlFeedBackCat').value)
        if (document.getElementById('ddlFeedBackCat').value == 0) {
            var userMsg = SListForAppMsg.Get("Feedback_ManageFeedback_aspx_01") == null ? "Select Feedback Type" : SListForAppMsg.Get("Feedback_ManageFeedback_aspx_01");
            ValidationWindow(userMsg, errorMsg);
//            alert('Select Feedback Type');
            document.getElementById('ddlFeedBackCat').focus();
            return false;
        }
    }
</script>

