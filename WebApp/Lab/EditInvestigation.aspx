<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditInvestigation.aspx.cs" Inherits="Lab_EditInvestigation" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
            <uc1:MainHeader ID="MainHeader" runat="server" />
            <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
              
        <div id="primaryContent">
            <div id="maincontent">
                <uc4:LeftMenu ID="LeftMenu1" runat="server" CSSStyle="hid" CSSMidStyle="top" />
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader"><asp:Label ID="Rs_SampleCapture" Text="Sample Capture" 
                                    runat="server" meta:resourcekey="Rs_SampleCaptureResource1"></asp:Label></li>
                        </ul>
                        <ul>
                            <li><uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" /></li>
                        </ul>
                    </h1>
                    <div class="rum">
                    
                    </div>
                </div>
            </div>
        </div>
        <uc2:Footer ID="footer" runat="server" />
    </div>
    


	<asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
