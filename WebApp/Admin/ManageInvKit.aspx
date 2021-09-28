<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageInvKit.aspx.cs" Inherits="Admin_ManageInvKit"
    meta:resourcekey="PageResource2" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Investigation Kit</title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateInvestigationKitDetails() {
           var objvarAlert = SListForAppMsg.Get("Admin_ManageInvKit_aspx_03") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageInvKit_aspx_03");
           var objvar17 = SListForAppMsg.Get("Admin_ManageInvKit_aspx_01") == null ? "Provide kit name" : SListForAppMsg.Get("Admin_ManageInvKit_aspx_01");
        
        
            if (document.getElementById('txtKitName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvKit.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide kit name');
                    return false;
                }

                document.getElementById('txtKitName').focus();
                return false;
            }
        }

        function checkSearchKitName() {
            if (document.getElementById('txtSearchKitName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\ManageInvKit.aspx_2");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide the search text to find the kit');
                    return false;
                }

                document.getElementById('txtSearchKitName').focus();
                return false;
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                    <tr>
                                        <td height="32">
                                            <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                                <tr>
                                                    <td colspan="5" id="us">
                                                        <asp:Literal runat="server" ID="ltHead" Text="Search for existing Kit details or click on Add New 
                                                Kit." meta:resourcekey="ltHeadResource2"></asp:Literal>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel7Resource2">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="padding: 3px;">
                                                            <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td align="right" style="width: 25%;">
                                                                        <asp:Label ID="Rs_EnterKitName" Text="Enter Kit Name" runat="server" meta:resourcekey="Rs_EnterKitNameResource2"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 35%;">
                                                                        <asp:TextBox ID="txtSearchKitName" ToolTip="Kit Name" CssClass="Txtboxlarge" runat="server"
                                                                            meta:resourcekey="txtSearchKitNameResource2"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Search the Kit"
                                                                            Style="cursor: pointer;" OnClientClick="javascript:return checkSearchKitName();"
                                                                            OnClick="btnSearch_Click" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSearchResource2" />
                                                                    </td>
                                                                    <td style="width: 40%;" align="center">
                                                                        <asp:LinkButton ID="addNewKit" Text="Add New Kit" Font-Underline="True" ToolTip="Click here to Add New Kit"
                                                                            ForeColor="#000333" runat="server" OnClick="addNewKit_Click" meta:resourcekey="addNewKitResource2"></asp:LinkButton>
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
                                        <td style="padding-bottom: 10px;">
                                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                                                meta:resourcekey="lblStatusResource2"></asp:Label>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" CssClass="mytable1" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                DataKeyNames="KitID,KitName" Width="97%" OnRowCommand="grdResult_RowCommand"
                                                OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource2">
                                                <PagerTemplate>
                                                    <tr>
                                                        <td align="center" colspan="6">
                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                meta:resourcekey="lnkPrevResource2" />
                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                meta:resourcekey="lnkNextResource2" />
                                                        </td>
                                                    </tr>
                                                </PagerTemplate>
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" />
                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                <Columns>
                                                    <asp:BoundField DataField="KitID" HeaderText="KitID" Visible="False" meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="KitName" HeaderText="Kit Name" meta:resourcekey="BoundFieldResource4">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="hidden" id="hdnKitID" runat="server"/>
                                                <table border="0" cellpadding="2" cellspacing="0" class="dataheader2" width="100%">
                                                    <tr>
                                                        <td style="height: 5px;">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 25%;">
                                                            <asp:Label ID="Rs_KitName" runat="server" meta:resourcekey="Rs_KitNameResource2"
                                                                Text="Kit Name"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 75%;">
                                                            <asp:TextBox ID="txtKitName" runat="server" MaxLength="60" meta:resourcekey="txtKitNameResource2"
                                                                ToolTip="Kit Name" CssClass="Txtboxlarge"></asp:TextBox>
                                                            &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 5px;">
                                                        </td>
                                                    </tr>
                                                </table>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnFinish" ToolTip="Click here to Save Kit Details" Style="cursor: pointer;"
                                                OnClientClick="return validateInvestigationKitDetails();" runat="server" OnClick="btnFinish_Click"
                                                Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                meta:resourcekey="btnFinishResource2" Width="58px" />
                                            <asp:Button ID="btnUpdate" Visible="False" OnClientClick="return validateInvestigationKitDetails();"
                                                runat="server" OnClick="btnUpdate_Click" Text="Save Changes" ToolTip="Click here to Change Kit Details"
                                                Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnUpdateResource2" Width="120px" />
                                            <asp:Button ID="btnDelete" Visible="False" OnClientClick="return validateInvestigationKitDetails();"
                                                runat="server" OnClick="btnDelete_Click" Text="Remove" CssClass="btn" ToolTip="Click here to Remove Kit Details"
                                                Style="cursor: pointer;" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                meta:resourcekey="btnDeleteResource2" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                ToolTip="Click here to Cancel, View the Home Page" Style="cursor: pointer;" onmouseout="this.className='btn'"
                                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource2" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
