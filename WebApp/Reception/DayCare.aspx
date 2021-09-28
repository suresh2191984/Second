<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DayCare.aspx.cs" Inherits="Reception_DayCare"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/DaycarePatientSearch.ascx" TagName="DaycarePatientSearch" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Daycare</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

     <script type="text/javascript">
         function CheckPatientSearch() {
             if (document.getElementById('ucDaycarePatientSearch_txtPatientNo').value == '' && document.getElementById('ucDaycarePatientSearch_txtPatientName').value == '' &&
    document.getElementById('ucDaycarePatientSearch_txtDOB').value == '' && document.getElementById('ucDaycarePatientSearch_txtRelation').value == '' &&
    document.getElementById('ucDaycarePatientSearch_txtLocation').value == '' && document.getElementById('ucDaycarePatientSearch_txtOthers').value == '' && document.getElementById('ucDaycarePatientSearch_txtURNo').value == '' && document.getElementById('ucDaycarePatientSearch_ddlNationality').value == '0' && document.getElementById('ucDaycarePatientSearch_ddlRegisterDate').value == '-1' && document.getElementById('ucDaycarePatientSearch_txtSmartCardNo').value == '') {
                 var userMsg = SListForApplicationMessages.Get('Reception\\DayCare.aspx_1');
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;
                     
                 }
                 else {
                     alert('Provide any one search category');
                     return false;
                 }
                 document.getElementById('ucDaycarePatientSearch_txtPatientNo').focus();
             }

             if (document.getElementById('ucDaycarePatientSearch_txtOthers').value != '') {
                 if (document.getElementById('ucDaycarePatientSearch_ddOthers').value == -1) {
                     var userMsg = SListForApplicationMessages.Get('Reception\\DayCare.aspx_7');
                     if (userMsg != null) {
                         alert(userMsg);
                         return false;
                         
                     }
                     else {
                         alert('Select others');
                         return false;
                     }
                     document.getElementById('ucDaycarePatientSearch_ddOthers').focus();
                 }
             }
             if (document.getElementById('ucDaycarePatientSearch_ddlRegisterDate').value == '3') {
                 if (document.getElementById('ucDaycarePatientSearch_txtFromPeriod').value == '' || document.getElementById('ucDaycarePatientSearch_txtToPeriod').value == '') {
                     var userMsg = SListForApplicationMessages.Get('Reception\\DayCare.aspx_8');
                     if (userMsg != null) {
                         alert(userMsg);
                         return false;

                     } else {
                     alert('Select Date');
                     return false;
                     }

                 }
             }
             return true;
         }
         function SearchFocus(e) {
             var key = window.event ? e.keyCode : e.which;
             if (key == 13)
                 document.getElementById('ucDaycarePatientSearch_btnSearch').focus();
         }

         function ValidatePatientName() {

             if (document.getElementById("ucDaycarePatientSearch_hdnPatientID").value == '') {
                 var userMsg = SListForApplicationMessages.Get('Reception\\DayCare.aspx_9');
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;

                 } else {
                 alert('Select patient name');
                 return false;
                     
                 }
             }
         }
    </script>

</head>
<body onkeypress="SearchFocus(event)" onload="pageLoadFocus('ucDaycarePatientSearch_txtPatientNo');" oncontextmenu="return false;">
    <form id="RecDayCare" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc11:PhyHeader ID="PhyHeader1" runat="server" />
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
        <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                         </ul>
                              
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc10:DaycarePatientSearch ID="ucDaycarePatientSearch" runat="server" />
                                </td>
                            </tr>
                            <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Rs_Selectapatientandoneofthefollowing" Text="Select a patient and one of the following" runat="server"></asp:Label>  
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlTheme">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

	<asp:HiddenField ID="hdnMessages" runat="server" />

    </form>
</body>
</html>
