<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintInterimBill.aspx.cs"
    Inherits="Billing_PrintInterimBill" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/DueChartList.ascx" TagName="DueRequest" TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Bill Search</title>
   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script>
        function Print_Btn_Click() {
            var sPage = document.getElementById("hdnFID").value
            window.open(sPage, '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            return false;
        }
    </script>

    <script>
        function fnCallPrint() {
            var prtContent = document.getElementById("pagetdPrint");
            var WinPrint = window.open('', '', 'left=-1,top=-1,width=10,height=10,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;

        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" class="defaultfontcolor" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                    <uc11:DueRequest ID="uctlDueRequest1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="display: none;" width="100%" runat="server" id="pagetdPrint" enableviewstate="false">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnBillSearch" runat="server" Text="Print" CssClass="btn" 
                                        OnClientClick="return Print_Btn_Click();" onmouseout="this.className='btn'" meta:resourcekey="btnBillSearchResource1" />
                                    <asp:Button ID="btnDynamicPrint" Visible="false" runat="server" Text="Print" CssClass="btn"
                                        OnClientClick="return fnCallPrint();"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnDynamicPrintResource1"/>
                                    &nbsp; &nbsp;
                                    <asp:Button ID="btnBack" runat="server" Text="Edit" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnFID" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
