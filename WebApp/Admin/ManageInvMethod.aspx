<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageInvMethod.aspx.cs"
    Inherits="Admin_ManageInvMethod" meta:resourcekey="PageResource1" %>

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
    <title>Manage Investigation Method</title>
    <%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>
    <style>
        .Txtboxlarge1
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 70px;
            width: 350px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
        }
        .style1
        {
            width: 458px;
        }
    </style>
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
                                        <asp:Literal runat="server" ID="ltHead" Text="Search for existing Method details or click on Add New 
                                                Method." meta:resourcekey="ltHeadResource1"></asp:Literal>
                                    </td>
                                </tr>
                                <tr id="trSearch">
                                    <td class="w-100p">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-100p">
                                                    <asp:Panel ID="Panel7" CssClass="dataheader2 bg-row" BorderWidth="1px" runat="server"
                                                        meta:resourcekey="Panel7Resource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="padding3">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-right w-25p">
                                                                                <asp:Label ID="lblEnterMethodName" runat="server" Text="Enter Method Name" meta:resourcekey="lblEnterMethodNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-18p">
                                                                                <asp:TextBox ID="txtSearchMethodName" ToolTip="Method Name" CssClass="Txtboxlarge"
                                                                                    runat="server" meta:resourcekey="txtSearchMethodNameResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td class="w-10p">
                                                                                <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Search Method" Style="cursor: pointer;"
                                                                                    OnClientClick="javascript:return checkSearchMethodName();" OnClick="btnSearch_Click"
                                                                                    Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                    meta:resourcekey="btnSearchResource1" />
                                                                            </td>
                                                                            <td class="w-40p a-center">
                                                                                <%--<asp:LinkButton ID="addNewMethod" ToolTip="Click here to Add New Method" ForeColor="#000333"
                                                            runat="server" OnClick="addNewMethod_Click" meta:resourcekey="addNewMethodResource1"><u>Add New Method</u></asp:LinkButton>--%>
                                                                                <asp:LinkButton ID="addNewMethod" href="#" ToolTip="Click here to Add New Method"
                                                                                    ForeColor="#000333" runat="server" OnClientClick="ShowAddNewMethod('AddNewMethod');"
                                                                                    meta:resourcekey="addNewMethodResource1" Text="&lt;u 
                                                                                    __designer:mapid=&quot;e&quot;&gt;Add New Method&lt;/u&gt;"></asp:LinkButton>
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
                                                        CellPadding="4" CssClass="mytable1 gridView w-97p" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                        DataKeyNames="MethodID,MethodName" OnRowCommand="grdResult_RowCommand" OnRowDataBound="grdResult_RowDataBound"
                                                        meta:resourcekey="grdResultResource1">
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
                                                            <asp:BoundField DataField="MethodID" HeaderText="MethodID" Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField DataField="MethodName" HeaderText="Method Name" meta:resourcekey="BoundFieldResource2">
                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="trAddNewMethod">
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <input type="hidden" id="hdnMethodID" runat="server" />
                                        <table class="dataheader2 w-100p">
                                            <tr>
                                                <td class="a-right w-25p">
                                                    <asp:Label ID="lblMethodName" runat="server" meta:resourcekey="lblMethodNameResource1"
                                                        Text="Method Name"></asp:Label>
                                                </td>
                                                <td class="a-left w-75p">
                                                    <asp:TextBox ID="txtMethodName" runat="server" MaxLength="250" meta:resourcekey="txtMethodNameResource1"
                                                        ToolTip="Method Name" CssClass="Txtboxlarge1"></asp:TextBox>
                                                    &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="style1">
                                        <asp:Button ID="btnFinish" OnClientClick="return validateInvestigationMethodDetails();"
                                            runat="server" OnClick="btnFinish_Click" ToolTip="Click here to Save Method Details"
                                            Style="cursor: pointer;" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                        <asp:Button ID="btnUpdate" Visible="False" ToolTip="Click here to Change Method Details"
                                            Style="cursor: pointer;" OnClientClick="return validateInvestigationMethodDetails();"
                                            runat="server" OnClick="btnUpdate_Click" Text="Save Changes" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnUpdateResource1" />
                                        <asp:Button ID="btnDelete" Visible="False" ToolTip="Click here to Remove Method Details"
                                            Style="cursor: pointer;" OnClientClick="return validateInvestigationMethodDetails();"
                                            runat="server" OnClick="btnDelete_Click" Text="Remove" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnDeleteResource1" />
                                        <%-- <asp:Button ID="btnCancel" runat="server" Text="Clear" ToolTip="Click here to Cancel, View the Home Page"
                                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" href="#" OnClientClick="ShowAddNewMethod('Clear');" meta:resourcekey="btnCancelResource1" />--%>
                                        <input type="button" id="btnCancel" value="Clear" style="cursor: pointer;" onclick="ShowAddNewMethod('Clear');"
                                            class="btn" onmouseout="this.className='btn'" tooltip="Click here to Clear, View the Home Page"
                                            onmouseover="this.className='btn btnhov'" meta:resourcekey="btnCancelResource1" />
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
$(document).ready(function() {
 objAlert = SListForAppMsg.Get("Admin_ManageInvMethod_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvMethod_aspx_Alert");
});
        function validateInvestigationMethodDetails() {
            var objuser1 = SListForAppMsg.Get("Admin_ManageInvMethod_aspx_01") == null ? "Provide method name" : SListForAppMsg.Get("Admin_ManageInvMethod_aspx_01");
            if (document.getElementById('txtMethodName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvMethod.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    ValidationWindow(objuser1, objAlert);
                    //alert('Provide method name');
                    return false;
                }

                document.getElementById('txtMethodName').focus();
                return false;
            }
        }

        function checkSearchMethodName() {
            var objuser2 = SListForAppMsg.Get("Admin_ManageInvMethod_aspx_02") == null ? "Provide the search text to find the method" : SListForAppMsg.Get("Admin_ManageInvMethod_aspx_02");
            if (document.getElementById('txtSearchMethodName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvMethod.aspx_2");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Provide the search text to find the method');
                    ValidationWindow(objuser2, objAlert);
                    return false;
                }
                document.getElementById('txtSearchMethodName').focus();
                return false;
            }
        }
        $(document).ready(function() {
            $('#trAddNewMethod').hide();
        });
        function ShowAddNewMethod(objvalue) {
            if (objvalue == "AddNewMethod") {
                $('#trAddNewMethod').show();
                $('#btnFinish').show();
                $('#trSearch').hide();
                $('#btnUpdate').hide();
                $('#btnDelete').hide();
            }
            if (objvalue == 'Clear') {
                $('#trAddNewMethod').hide();
                $('#trSearch').show();
                $('#grdResult').hide();
                $('#txtMethodName').val('');
            }
        }
        function ShowSuccess(msg,obj) {

            if (obj != 'Load') {
                ShowAddNewMethod('Clear');
                alert(msg);
            }
            else {
                $('#trAddNewMethod').show();
                $('#grdResult').show();
            }
        }
    </script>

</body>
</html>
