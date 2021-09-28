<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicUserControl.aspx.cs" Inherits="Admin_DynamicUserControl" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="ucPatHeader" %>

<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<script type="text/javascript" src="../Scripts/bid.js"></script>
<script type="text/javascript" src="../Scripts/test.js"></script>
<%@ Register Src="../CommonControls/DynamicUserControl.ascx" TagName="DynamicUserControl" TagPrefix="ucDynamic" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient EMR</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        input:focus
        {
            /*background: #8AC0DA;*/
            outline: .25px solid #8f0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
   <asp:ScriptManager ID="scm1" runat="server">
    <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
    </Services>
    </asp:ScriptManager>
    <asp:UpdatePanel ID ="upEMR" runat ="server">
    <ContentTemplate>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <ucPatHeader:PatientHeader ID="patientHeader" runat="server" />
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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                          <ucDynamic:DynamicUserControl ID="ucDynamic" runat="server" />
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc14:Footer ID="Footer1" runat="server" />
    </div>
    </ContentTemplate>
  
   </asp:UpdatePanel>
    </form>
</body>
</html>
