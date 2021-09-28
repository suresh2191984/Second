<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ipPerformInvestigation.aspx.cs"
    Inherits="Lab_ipPerformInvestigation" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
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
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                    <div class="contentdata" id="dMain">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" CellPadding="4"
                                            AutoGenerateColumns="False" PagerSettings-Mode="NextPrevious" ForeColor="#333333"
                                            CssClass="mytable1" OnRowCommand="grdResult_RowCommand" meta:resourcekey="grdResultResource1">
                                            <PagerTemplate>
                                                <tr>
                                                    <td colspan="6" align="center">
                                                        <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="False"
                                                            CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px"
                                                            meta:resourcekey="lnkPrevResource1" />
                                                        <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="False"
                                                            CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px"
                                                            meta:resourcekey="lnkNextResource1" />
                                                    </td>
                                                </tr>
                                            </PagerTemplate>
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerSettings Mode="NextPrevious"></PagerSettings>
                                            <Columns>
                                                <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatinetVisitID"
                                                    meta:resourcekey="BoundFieldResource1" />
                                                <asp:TemplateField HeaderText="Patient Number" ItemStyle-HorizontalAlign="Center"
                                                    meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPatientNumber" Text='<%# Bind("PatientNumber") %>' runat="server"
                                                            meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Patient Name" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkPerformInv" Font-Bold="True" Font-Size="12px" CommandName="IPPerformInv"
                                                            Font-Underline="True" Text='<%# Bind("Name") %>' CommandArgument='<%# Bind("IPInvSampleCollectionMasterID") %>'
                                                            ToolTip="Click to capture the performed Investigations" runat="server" meta:resourcekey="lnkPerformInvResource1"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="IpSampleColletedID" Visible="false" ItemStyle-Width="14%"
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSCMID" runat="server" Text='<%# Bind("IPInvSampleCollectionMasterID") %>'
                                                            meta:resourcekey="lblSCMIDResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="14%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Sample Collected Time" DataField="CollectedDateTime"
                                                    ItemStyle-Width="18%" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle Width="18%"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
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
