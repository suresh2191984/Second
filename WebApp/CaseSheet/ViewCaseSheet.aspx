<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCaseSheet.aspx.cs" Inherits="CaseSheet_ViewCaseSheet" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/FeesEntry.ascx" TagName="Billing" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>View Case Sheet</title>
  <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>
   <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
    <script language="javascript" type="text/javascript">
            function PopUps() {
          
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=400,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0";
            var chk;
            if(document.getElementById('chkheader').checked==true)
            {
            chk ='Y';
            }
            else
            {
            chk ='N';
            }
         
            
          var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"].ToString()%>&pagetype=DCPR&IsPopup=Y&chk="+chk+"";
            window.open(strURL, "", strFeatures, true);
            
        }
        
        function avoiddoubleentry(bid) {
            document.getElementById(bid).style.display = 'none';
        }
    </script>

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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc6:PatientHeader ID="PatientHeader1" runat="server" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
                            <tr>
                                <td>
                                    <uc3:OPCaseSheet ID="OPCaseSheet1" runat="server" />
                                </td>
                            </tr>
                            <tr style="width: 100%;">
                                <td style="width: 100%;" align="center">
                                    <uc8:Billing ID="FeesEntry1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry(this.id);"
                                        OnClick="btnOk_Click" meta:resourcekey="btnOkResource1" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" 
                                        meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClientClick="PopUps()" 
                                        OnClick="btnPrint_Click" meta:resourcekey="btnPrintResource1" />
                                        <asp:CheckBox ID ="chkheader" Text ="With Header" runat ="server" style="display:none;"/> 
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px; display: none;" 
        meta:resourcekey="btnHideValuesResource1" />
    <input type="hidden" id="hdnRedirectedBy" runat="server" />
    <input type="hidden" id="hdnRedirectedTo" runat="server" />
    </form>
</body>
</html>
