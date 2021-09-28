<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPInvestigationProfile.aspx.cs"
    Inherits="Physician_IPInvestigationProfile" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc1" %>--%>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%--<%@ Register Src="Profile.ascx" TagName="Profile" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Profile.ascx" TagName="Profile" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Order Investigation</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script language="javascript" type="text/javascript">
        function ValidateInv() {
            var inv = document.getElementById('InvestigationControl1_iconHid').value;
            if (inv == "") {
                alert('Choose atleast one investigation');
                document.getElementById('InvestigationControl1_txtGroup').focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:PatientHeader ID="PatientHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
                            <tr>
                                <td colspan="5">
                                    <%--<uc8:Profile ID="Profile1" runat="server" />--%>
                                    <uc9:InvestigationControl ID="InvestigationControl1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    &nbsp;
                                </td>
                                <td style="width: 20%">
                                    &nbsp;
                                    <asp:Button ID="btnDueChart" runat="server" TabIndex="26" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Add to Due Chart" OnClick="btnDueChart_Click"
                                        meta:resourcekey="btnDueChartResource1" />
                                </td>
                                <td style="width: 20%">
                                    <asp:Button ID="btnPayment" runat="server" TabIndex="26" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Make Payment" OnClick="btnPayment_Click"
                                        meta:resourcekey="btnPaymentResource1" />
                                </td>
                                <td style="width: 20%">
                                    <asp:Button ID="btnCancel" runat="server" TabIndex="26" Text="Cancel" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                </td>
                                <td style="width: 20%">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
        <div>
    </form>
</body>
</html>
