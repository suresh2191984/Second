<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrescriptionSearch.aspx.cs"
    Inherits="Corporate_PrescriptionSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/Corporate/PrescriptionSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
 <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">


        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else
             {
                 alert('URL Not Found');
                 return false;
            }

           
            return true;
        }
    
    
    
    
    
    
        function ReDirectPage(URL) {
            window.location.href = URL;
        }
        function PrintDynamic(path) {
           
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = path;
                var PrintWindow = window.open(strURL, "", strFeatures);
                PrintWindow.focus();
                PrintWindow.print();
            }
           


           
    </script>
    
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" >
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
                <uc3:Header ID="UsrHeader1" runat="server" />
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
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Loading" Text="Loading..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <uc2:PatientSearch ID="uctlPatientSearch" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="trAction" runat="server" visible="False">
                                     <td colspan="3" align="center" nowrap="nowrap" runat="server">
                                      <asp:Label ID="Rs_Info" Text="Select a prescription and perform one of the following" runat="server"
                                         meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                      <asp:DropDownList id="ddlAction" runat="server" CssClass="ddlsmall">
                                      </asp:DropDownList> 
                                      <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return ValidatePatientName();" CssClass="btn"  OnClick="btnGo_Click" 
                                      meta:resourcekey="btnGoResource1"/>
                                     </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td>
                                            <asp:Label ID="lblloctaion" Text="Location" runat="server" 
                                                meta:resourcekey="lblloctaionResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlLocatiopn" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlLocatiopnResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    
                                </table>
                                <asp:HiddenField ID="hdnPatientAgeLimit" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
            <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
