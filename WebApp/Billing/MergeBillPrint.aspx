<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MergeBillPrint.aspx.cs" Inherits="Billing_MergeBillPrint" %>
<%@ Register Src="~/CommonControls/BillPrint.ascx" TagName="BillPrint"
    TagPrefix="uc17" %>
    <%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                           
                            <li>
                                <uc12:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            
                           <tr>
                           <td id="pagetdPrint">
                           <uc17:BillPrint ID="ucBillPrint" runat="server" />
                           </td>
                           </tr>
                            <tr>
                                <td align="center">                                
                                   
                                    <asp:Button ID="btnDynamicPrint"  runat="server" Text="Print" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" OnClientClick="return fnCallPrint();"
                                        onmouseout="this.className='btn'" />
                                     <asp:Button ID="btnBack" Text="Back" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnHome_Click" />
                               
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc11:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
        <script language="javascript" type="text/javascript">
        function PrintReport() {
        
             
            var dp;
            if(document.getElementById('chkDuplicate').checked == true)
            {
                dp = "1";
            }
            else
            {
                dp = "0";
            }
            
            var chkheader;
            if(document.getElementById('chkheader').checked == true)
            {
                chkheader = 'Y';
            }
            else
            {
                chkheader = 'N';
            }
            
            var lstSplit=document.getElementById('chkSplit').checked==true?"Y":"N";           
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800,left=0,top=0";
            //var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp;
            var strURL = "../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y";
            var WinPrint = window.open(strURL, "", strFeatures, true);
            WinPrint.print();
            return false;
        }
        
        
        function fnCallPrint() { 

            var prtContent = document.getElementById("pagetdPrint"); 
//            var x=document.getElementById('tblBill').rows;
//            var y=x[0].cells;
//            var z= y[0].innerHTML;
//            prtContent.innerHTML=prtContent.innerHTML.replace(' [Duplicate Copy]','');
//            var m=z +' [Duplicate Copy]';
//            if(document.getElementById('chkDuplicate').checked == true)
//            {
//                prtContent.innerHTML=prtContent.innerHTML.replace(z,m);
//            } 

            var WinPrint = window.open('', '', 'left=-1,top=-1,height=600,width=700,toolbar=0,scrollbars=yes,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            return false;

        }
        </script>
</body>
</html>
