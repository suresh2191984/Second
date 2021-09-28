<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Diagnose.aspx.cs" Inherits="Physician_Diagnose" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%--<%@ Register Src="~/Physician/Header.ascx" TagName="DocHeader" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Doctor's Home</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/AC_RunActiveContent.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnHideValues">
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
                <uc1:mainheader id="MainHeader" runat="server" />
                <uc3:patientheader id="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" height="640px" valign="top" class="tdspace">
                    <div class="flashmenu">
                        <%--  <embed width="795" height="525" runat="server" name="embFlsh" id="embFlsh" />--%>
                        <div id="divMale" style="display: none">

                            <script type="text/javascript">
                                AC_FL_RunContent('codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0', 'width', '795', 'height', '525', 'title', 'Male', 'src', '../Physician/MDiagnose', 'quality', 'high', 'pluginspage', 'http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash', 'movie', '../Physician/MDiagnose'); //end AC code
                            </script>

                            <noscript>
                                <%--<table>
                                <tr><td align="center">--%>
                                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"
                                    width="795" height="525" title="Male">
                                    <param name="movie" value="../Physician/MDiagnose.swf" />
                                    <param name="quality" value="high" />
                                    <embed src="../Physician/MDiagnose.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
                                        type="application/x-shockwave-flash" width="795" height="525"></embed>
                                </object>
                                <%-- </td></tr>
                            </table>--%>
                            </noscript>
                        </div>
                        <div id="divFemale" style="display: none">

                            <script type="text/javascript">
                                AC_FL_RunContent('codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0', 'width', '795', 'height', '525', 'title', 'Female', 'src', '../Physician/FDiagnose', 'quality', 'high', 'pluginspage', 'http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash', 'movie', '../Physician/FDiagnose'); //end AC code
                            </script>

                            <noscript>
                                <%--<table>
                                <tr><td align="center">--%>
                                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"
                                    width="795" height="525" title="Female">
                                    <param name="movie" value="../Physician/FDiagnose.swf" />
                                    <param name="quality" value="high" />
                                    <embed src="../Physician/FDiagnose.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
                                        type="application/x-shockwave-flash" width="795" height="525"></embed>
                                </object>
                                <%--</td></tr>
                            </table>--%>
                            </noscript>
                        </div>
                        <table width="100%">
                            <tr>
                                <td align="Center">
                                    <asp:Button runat="server" ID="btnBack" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" 
                                        meta:resourcekey="btnBackResource1" />
                                    <asp:Button runat="server" ID="btnQuickDiagnose" Text="Qucik Diagnosis" CssClass="btn"
                                        onmouseover="this.className='btn btnhov1'" onmouseout="this.className='btn'"
                                        OnClick="btnQuickDiagnose_Click" 
                                        meta:resourcekey="btnQuickDiagnoseResource1" />
                                    <asp:Label ID="lblRedirectURL" runat="server" Visible="False" 
                                        meta:resourcekey="lblRedirectURLResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:footer id="Footer" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" 
        meta:resourcekey="btnHideValuesResource1" />
    <input type="hidden" id="hdnRedirectedBy" runat="server" />
    <input type="hidden" id="hdnRedirectedTo" runat="server" />
    </form>
</body>
</html>
