<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditReferrals.aspx.cs" Inherits="Referrals_EditReferrals" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/ReferedInvestigation.ascx" TagName="ReferedInvestigation"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Refered Investigation</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="Rec" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblReferrals" runat="server" 
                                        meta:resourcekey="lblReferralsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:GridView ID="gvInvestigations" runat="server" Width="90%" AutoGenerateColumns="False"
                                        class="defaultfontcolor" ShowFooter="True" 
                                        OnRowDataBound="gvInvestigations_RowDataBound" 
                                        meta:resourcekey="gvInvestigationsResource1">
                                        <HeaderStyle CssClass="Duecolor" />
                                        <PagerStyle CssClass="Duecolor1" HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="select" 
                                                meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:CheckBox Checked="True" ID="chkTest" runat="server" 
                                                        meta:resourcekey="chkTestResource1" />
                                                    <asp:HiddenField ID="hdnReferralID" runat="server" 
                                                        Value='<%# Bind("ReferralID") %>'>
                                                    </asp:HiddenField>
                                                    <asp:HiddenField ID="hdnReferralDetailsID" runat="server" 
                                                        Value='<%# Bind("ReferralDetailsID") %>'>
                                                    </asp:HiddenField>
                                                    <asp:HiddenField ID="hdnID" runat="server" 
                                                        Value='<%# Bind("ReferedByVisitID") %>'>
                                                    </asp:HiddenField>
                                                    <asp:HiddenField ID="hdnType" runat="server"></asp:HiddenField>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" 
                                                        Text='<%# Bind("ReferralNotes") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Performing Org" 
                                                meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlPerformingOrg" runat="server" 
                                                        meta:resourcekey="ddlPerformingOrgResource1">
                                                    </asp:DropDownList>
                                                    <asp:Image ImageUrl="../Images/starbutton.png" Visible="False" ID="imgPaid" 
                                                        runat="server" meta:resourcekey="imgPaidResource1" />
                                                    <asp:HiddenField ID="hdnPerforming" runat="server"></asp:HiddenField>
                                                    <asp:HiddenField ID="hdnReferralStatus" Value='<%# Bind("OrderedInvStatus") %>' 
                                                        runat="server">
                                                    </asp:HiddenField>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Status" DataField="ReferralStatus" 
                                                meta:resourcekey="BoundFieldResource1" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolorbig" height="32px">
                                    <div id="divPaid" runat="server" visible="false">
                                        <asp:Image ImageUrl="../Images/starbutton.png" ID="imgPaid" runat="server" 
                                            meta:resourcekey="imgPaidResource2" />
                                        <asp:Label ID="Rs_AmountPaidInReferredOrg" Text="Amount Paid In Referred Org" 
                                            runat="server" meta:resourcekey="Rs_AmountPaidInReferredOrgResource1"></asp:Label>
                                        <asp:Label ID="lblOrg" runat="server" meta:resourcekey="lblOrgResource1"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolorbig" height="32px">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnUpdate" Text="Update" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" 
                                        OnClientClick="return orderValidation();" OnClick="btnUpdate_Click" 
                                        meta:resourcekey="btnUpdateResource1" />
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnStatus" Value="Referred" runat="server"></asp:HiddenField>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script language="javascript" type="text/javascript">
        function orderValidation() {
            if (document.getElementById('hdnStatus').value != 'Referred') {
                var agree = confirm("Amount has to be paid in referred hospital. Do you wish to continue?");
                if (agree)
                    return true;
                else
                    return false;
            }
        }

    </script>

</body>
</html>
