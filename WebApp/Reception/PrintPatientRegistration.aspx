<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintPatientRegistration.aspx.cs"
    Inherits="Reception_PrintPatientRegistration" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/PrintPatientRegistration.ascx" TagName="PrintPatRegistration"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PrintIPAdmissionDetails.ascx" TagName="PrintIP"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/ESLabelPrint.ascx" TagName="ESLabelPrint" TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('printPatientReg');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                <uc2:Header ID="Header2" runat="server" />
                <uc1:Header ID="ReceptionHeader" runat="server" />
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
                        <table width="100%">
                            <tr>
                                <td align="left">
                                    <table border="0" id="maintable" runat="server" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <div id="printPatientReg" runat="server">
                                                    <uc9:PrintPatRegistration ID="ucPatReg" runat="server" />
                                                    <uc10:PrintIP ID="ucPrintIP" runat="server" />
                                                    <uc11:ESLabelPrint ID="ESLabelPrint" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr><td align="center"><asp:UpdatePanel ID ="upPrint" runat ="server">
                                        <ContentTemplate>
                                        <asp:Button ID="btnPrint" runat="server" Text="Print" Width="100px" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return popupprint();" />
                                </ContentTemplate></asp:UpdatePanel></td></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
