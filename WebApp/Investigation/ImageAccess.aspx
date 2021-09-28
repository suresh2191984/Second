<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImageAccess.aspx.cs" Inherits="Investigation_ImageAccess"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Image Access</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
   
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
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
        <div id="primaryContent">
            <div id="maincontent">
                <uc1:LeftMenu ID="LeftMenu1" runat="server" CSSStyle="hid" CSSMidStyle="top" />
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader">Image Access</li>
                        </ul>
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </h1>
                    <div class="rum">
                    </div>
                </div>
            </div>
        </div>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
