<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageInvPrinciple.aspx.cs"
    Inherits="Admin_ManageInvPrinciple" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Investigation Principle</title>
</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <%-- <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                <table class="w-100p searchPanel">
                    <tr>
                        <td class="h-32">
                            <table id="mytable1" class="w-100p">
                                <tr>
                                    <td colspan="5" id="us">
                                        <asp:Literal runat="server" ID="ltHead" Text="Search for existing Principle details or click on Add New 
                                                Principle." meta:resourcekey="ltHeadResource1"></asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="trSearch">
                        <td>
                            <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel7Resource1">
                                <table class="w-100p bg-row">
                                    <tr>
                                        <td class="padding3">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-right w-25p">
                                                        <asp:Label ID="Rs_EnterPrincipleName" Text="Enter Principle Name" runat="server"
                                                            meta:resourcekey="Rs_EnterPrincipleNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-35p">
                                                        <asp:TextBox ID="txtSearchPrincipleName" ToolTip="Principle Name" CssClass="Txtboxlarge"
                                                            runat="server" meta:resourcekey="txtSearchPrincipleNameResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Search the Principle"
                                                            Style="cursor: pointer;" OnClientClick="javascript:return checkSearchPrincipleName();"
                                                            OnClick="btnSearch_Click" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                    <td class="w-40p a-center">
                                                        <%-- <asp:LinkButton ID="addNewPrinciple" Text="Add New  Principle" Font-Underline="True"
                                                            ToolTip="Click here to Add New Principle" ForeColor="#000333" runat="server"
                                                            OnClick="addNewPrinciple_Click" meta:resourcekey="addNewPrincipleResource1"></asp:LinkButton>--%>
                                                        <asp:LinkButton ID="addNewPrinciple" href="#" Text="Add New  Principle" Font-Underline="True"
                                                            ToolTip="Click here to Add New Principle" ForeColor="#000333" runat="server"
                                                            OnClientClick="ShowAddNewPrinciple('AddNewPrinciple');" 
                                                            meta:resourcekey="addNewPrincipleResource1"></asp:LinkButton>
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
                        <td class="paddingB10">
                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                                meta:resourcekey="lblStatusResource1"></asp:Label>
                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                CellPadding="4" CssClass="mytable1 gridView w-100p" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                DataKeyNames="PrincipleID,PrincipleName" OnRowCommand="grdResult_RowCommand"
                                OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                <PagerTemplate>
                                    <tr>
                                        <td class="a-center" colspan="6">
                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                meta:resourcekey="lnkPrevResource1" />
                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                meta:resourcekey="lnkNextResource1" />
                                        </td>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle CssClass="dataheader1" />
                                <RowStyle Font-Bold="False" />
                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                <Columns>
                                    <asp:BoundField DataField="PrincipleID" HeaderText="PrincipleID" Visible="False"
                                        meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField DataField="PrincipleName" HeaderText="Principle Name" meta:resourcekey="BoundFieldResource2">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr id="trAddNewPrinciple">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <input type="hidden" id="hdnPrincipleID" runat="server" />
                                        <table class="dataheader2 w-100p">
                                            <tr>
                                                <td class="h-5">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right w-25p">
                                                    <asp:Label ID="Rs_PrincipleName" runat="server" meta:resourcekey="Rs_PrincipleNameResource1"
                                                        Text="Principle Name"></asp:Label>
                                                </td>
                                                <td class="a-left w-75p">
                                                    <asp:TextBox ID="txtPrincipleName" runat="server" MaxLength="60" meta:resourcekey="txtPrincipleNameResource1"
                                                        ToolTip="Principle Name" CssClass="Txtboxlarge"></asp:TextBox>
                                                    &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="h-5">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center" colspan="4">
                                        <asp:Button ID="btnFinish" ToolTip="Click here to Save Principle Details" Style="cursor: pointer;"
                                            OnClientClick="return validateInvestigationPrincipleDetails();" runat="server"
                                            OnClick="btnFinish_Click" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                        <asp:Button ID="btnUpdate" Visible="False" OnClientClick="return validateInvestigationPrincipleDetails();"
                                            runat="server" OnClick="btnUpdate_Click" Text="Save Changes" ToolTip="Click here to Change Principle Details"
                                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnUpdateResource1" />
                                        <asp:Button ID="btnDelete" Visible="False" OnClientClick="return validateInvestigationPrincipleDetails();"
                                            runat="server" OnClick="btnDelete_Click" Text="Remove" CssClass="btn" ToolTip="Click here to Remove Principle Details"
                                            Style="cursor: pointer;" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            meta:resourcekey="btnDeleteResource1" />
                                        <input type="button" id="btnCancel" value="Clear" style="cursor: pointer;" onclick="ShowAddNewPrinciple('Clear');"
                                            class="btn" onmouseout="this.className='btn'" tooltip="Click here to Clear, View the Home Page"
                                            onmouseover="this.className='btn btnhov'" />
                                        <%--<asp:Button ID="btnCancel" runat="server" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                ToolTip="Click here to Cancel, View the Home Page" Style="cursor: pointer;" onmouseout="this.className='btn'"
                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        var objAlert;
        $(function() {
         objAlert = SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_Alert");
        });
        function validateInvestigationPrincipleDetails() {
            var objProName = SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_01") == null ? "Provide principle name" : SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_01");
            if (document.getElementById('txtPrincipleName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvPrinciple.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    //return false;
                }
                else {
                    //alert('Provide principle name');
                    ValidationWindow(objProName, objAlert);
                    // return false;
                }

                document.getElementById('txtPrincipleName').focus();
                return false;
            }
        }

        function checkSearchPrincipleName() {
            var objSearch = SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_02") == null ? "Provide the search text to find the principle" : SListForAppMsg.Get("Admin_ManageInvPrinciple_aspx_02");
            if (document.getElementById('txtSearchPrincipleName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvPrinciple.aspx_2");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    // return false;
                }
                else {
                    // alert('Provide the search text to find the principle');
                    ValidationWindow(objSearch, objAlert);
                    // return false;
                }

                document.getElementById('txtSearchPrincipleName').focus();
                return false;
            }
        }
        $(document).ready(function() {
            $('#trAddNewPrinciple').hide();
        });
        function ShowAddNewPrinciple(objvalue) {
            if (objvalue == "AddNewPrinciple") {
                $('#trAddNewPrinciple').show();
                $('#btnFinish').show();
                $('#trSearch').hide();
                $('#grdResult').hide();
                $('#btnUpdate').hide();
                $('#btnDelete').hide();
            }
            if (objvalue == 'Clear') {
                $('#trAddNewPrinciple').hide();
                $('#trSearch').show();
                $('#grdResult').hide();
                $('#txtPrincipleName').val('');
            }
        }
        function ShowSuccess(msg, obj) {
            var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvPrinciple.aspx_1");

            if (obj != 'Load') {
                ShowAddNewPrinciple('Clear');
                //                alert(msg);  andrews
                ValidationWindow(msg, objAlert);
            }
            else {
                $('#trAddNewPrinciple').show();
                $('#grdResult').show();
            }
        }

    </script>

</body>
</html>
