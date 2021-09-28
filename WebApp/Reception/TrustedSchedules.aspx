<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrustedSchedules.aspx.cs" Inherits="Reception_Home" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    
    <title>Trusted Schedules </title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
   
</script>

    
</head>
<body  onContextMenu="return false;">
    <form id="RecHome" runat="server"  defaultfocus="ddlTrustedOrgs">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
              <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
              </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
              
       <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="Center">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                        <table width="100%" >
                                        <tr>
                                        <td align="right">
                                            <asp:Label ID="Rs_SelectOrganization" Text="Select Organization:" 
                                                runat="server" meta:resourcekey="Rs_SelectOrganizationResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                        <asp:DropDownList ID="ddlTrustedOrgs" runat="server" AutoPostBack="True"
                                                onselectedindexchanged="ddlTrustedOrgs_SelectedIndexChanged" 
                                                meta:resourcekey="ddlTrustedOrgsResource1"></asp:DropDownList>
                                        </td>
                                        
                                        </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <ps:PSchedule ID="phySch" runat="server" />
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                           
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
