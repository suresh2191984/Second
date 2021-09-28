<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefedInvestigation.aspx.cs"
    Inherits="Reception_RefedInvestigation" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigations</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
   
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="RecHome" runat="server">
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
                                    <asp:GridView ID="gvInvestigations" runat="server" Width="90%" AutoGenerateColumns="False"
                                        class="defaultfontcolor" ShowFooter="True" OnRowDataBound="gvInvestigations_RowDataBound"
                                        meta:resourcekey="gvInvestigationsResource1">
                                        <HeaderStyle CssClass="Duecolor" />
                                        <PagerStyle CssClass="Duecolor1" HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno" Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSno" runat="server" Text='<%# Bind("ProcedureType") %>' meta:resourcekey="lblSnoResource1"></asp:Label>
                                                    <asp:Label ID="lblisVariable" Visible="False" runat="server" Text='<%# Bind("IsVariable") %>'
                                                        meta:resourcekey="lblisVariableResource1"></asp:Label>
                                                    <asp:Label ID="lblID" runat="server" Visible="False" Text='<%# Bind("ID") %>' meta:resourcekey="lblIDResource1"></asp:Label>
                                                    <asp:Label ID="lblisGroup" runat="server" Visible="False" Text='<%# Bind("IsGroup") %>'
                                                        meta:resourcekey="lblisGroupResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="select" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:CheckBox Checked="True" ID="chkTest" runat="server" meta:resourcekey="chkTestResource1" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblOthers" Text="Others" runat="server" meta:resourcekey="lblOthersResource1"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Descrip") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtFooterDescription" runat='server' meta:resourcekey="txtFooterDescriptionResource1"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" runat="server" Width="70px" Text='<%# Bind("Amount") %>'
                                                        meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtFooterAmount" runat="server" Width="70px" meta:resourcekey="txtFooterAmountResource1"></asp:TextBox>
                                                    &nbsp;
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnAdd_Click" Text="Add" meta:resourcekey="btnAddResource1" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Performing Org" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlPerformingOrg" runat="server" meta:resourcekey="ddlPerformingOrgResource1">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" Width="55px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnAmount" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
