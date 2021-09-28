<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoicePrinting.aspx.cs" Inherits="Invoice_InvoicePrinting" meta:resourcekey="PageResource1" %>
 
<%@ Register Src="~/CommonControls/InvoicePrinting.ascx" TagName="BillPrint" TagPrefix="uc3" %>
 
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
 
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice Print</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        
        function fnCallPrint() {

            document.getElementById('BillPrint_trInvoicePage').style.display = 'block';
            var prtContent = document.getElementById("pagetdPrint"); 

            var WinPrint = window.open('', '', 'left=-1,top=-1,toolbar=0,scrollbars=yes,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.window.document.close();
            WinPrint.focus();
            WinPrint.print();
            document.getElementById('BillPrint_trInvoicePage').style.display = 'none';
            return false;

        }
            
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header" runat="server">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc10:MainHeader ID="MHead" runat="server" />
                <uc8:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc9:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        runat="server" style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul id="content" runat="server">
                            <asp:Label ID="lblDiagnosisHeader" runat="server" 
                                meta:resourcekey="lblDiagnosisHeaderResource1" ></asp:Label>
                            <li>
                                <uc12:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            
                            <tr id="pagetdPrint" >
                                <td >
                                    <uc3:BillPrint ID="BillPrint" runat="server"  />
                                   
                                </td>
                            </tr>
                          
                            <tr>
                                <td style="display: none;" width="100%" runat="server"  >
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="return fnCallPrint()" Width="5%"
                                        runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1"/>
                                  
                                    <asp:Button ID="btnBack" Text="Back" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnBackResource1" />
                                  
                                    <asp:HiddenField ID="hdnPopup" runat="server" Value="0" />
                                </td>
                            </tr>
                        </table>
                        
                    </div>
                </td>
            </tr>
        </table>
        <uc11:Footer ID="Footer1" runat="server" />
    </div>
    </form>
    
</body>
</html>