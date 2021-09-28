<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Admin_Home" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PatientAccessHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/PatientOrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Home Page</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
       
        
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="Div1">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="Header" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <div id="primaryContent">
            <div id="maincontent">
                <uc1:LeftMenu ID="LeftMenu" runat="server" CSSStyle="hid" CSSMidStyle="top" />
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader"><asp:Label ID="lbhme" runat="server" Text="Home" 
                                    meta:resourcekey="lbhmeResource1"></asp:Label></li>
                        </ul>
                    </h1>
                    <div class="rum">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <uc5:Footer ID="Footer1" runat="server" />
        </div>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
