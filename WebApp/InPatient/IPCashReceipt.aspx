<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPCashReceipt.aspx.cs" Inherits="InPatient_IPCashReceipt" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
 
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/CashReceipt.ascx" TagName="CashReceipt" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/CreditReceipt.ascx" TagName="CreditReceipt" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>InPatient Cash Receipt </title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
       function CallPrint() {
           var prtContent = document.getElementById('printArea');
           
           var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
           WinPrint.document.write(prtContent.innerHTML);
           WinPrint.document.close();
           WinPrint.focus();
           WinPrint.print();
           WinPrint.close();
       }
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
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
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div align="center" id="printArea">
                            <uc9:CashReceipt ID="Cashreceipt" runat="server" />
                            <div id="divSecPage" runat="server">
                                <p style="page-break-before: always;">
                                </p>
                            </div>
                            <uc10:CreditReceipt ID="Creditreceipt" runat="server" />
                            <br />
                        </div>
                        <asp:Button ID="btnBillPrint" runat="server" Text="PrintBill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClientClick="CallPrint();return true;" 
                            OnClick="btnBillPrint_Click" meta:resourcekey="btnBillPrintResource1" />
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
