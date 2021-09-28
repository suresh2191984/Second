<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportsDisplay.aspx.cs" Inherits="Reception_ReportSampleDisplay" meta:resourcekey="PageResource1" %>
<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ReportDisplay.ascx" TagName="ReportDisplay" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Reports Display</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="form1" runat="server">
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
        <div id="primaryContent">
            <div id="maincontent">
                <uc1:LeftMenu ID="LeftMenu1" runat="server" CSSStyle="hid" CSSMidStyle="top" />
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader"><asp:Label ID="Rs_ReportDetails" Text="Report Details" 
                                    runat="server" meta:resourcekey="Rs_ReportDetailsResource1"></asp:Label> </li>
                        </ul>
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </h1>
                    <div class="rum">
                    <div id="divReportControls" runat="server" ></div>
                        <%--<uc8:ReportDisplay ID="ucReortDisplay" runat="server" />--%>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>

