<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invsample.aspx.cs" Inherits="Investigation_invsample" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="Profile.ascx" TagName="Profile" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Profile.ascx" TagName="Profile" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/InvSampleControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Order Investigation</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/bid.js"></script>

   <%-- <script language="javascript" type="text/javascript">
        function ValidateInv() {
            var inv = document.getElementById('InvestigationControl1_iconHid').value;
            if (inv == "") {
                alert('Choose atleast one investigation');
                document.getElementById('InvestigationControl1_txtGroup').focus();
                return false;
            }
            return true;
        }
    </script>--%>

</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
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
                                        <td style="width: 20%" style="display: none;">
                                            <asp:RadioButton ID="rdoPayNow" runat="server" GroupName="grprdo" Text="Pay Now" />
                                            &nbsp;
                                            <asp:RadioButton ID="rdoPayLater" runat="server" Checked="True" GroupName="grprdo"
                                                Text="Pay Later" />
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                            <asp:Button ID="btnSave" runat="server" TabIndex="26" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Text="Save" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnCancel" runat="server" TabIndex="26" Text="Cancel" CssClass="btn"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                        <td style="width: 20%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
        <div>
    </form>
</body>
</html>

