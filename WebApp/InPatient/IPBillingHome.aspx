<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPBillingHome.aspx.cs" Inherits="InPatient_IPBillingHome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/InPatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc112" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script type ="text/javascript" language="javascript" >
    
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else if(key=="InPatient\\IPBillingHome.aspx.cs_2")
            {
            alert('This cannot be performed as the Room is not occupied by this patient');
            return false ;
            }
              else if(key=="InPatient\\IPBillingHome.aspx.cs_3")
            {
            alert('RedirectURL Not Found');
            return false ;
            }
         
           return true;
        }

    </script>

    <%--    <script type="text/javascript">
        function CheckINPatientSearch() {
        
    if (document.getElementById('ucINPatientSearch_txtPatientNo').value == '' && document.getElementById('ucINPatientSearch_txtPatientName').value == '' &&
    document.getElementById('ucINPatientSearch_txtDOB').value == '' && document.getElementById('ucINPatientSearch_txtRoomNo').value == '' &&
    document.getElementById('ucINPatientSearch_txtCellNo').value == '' && document.getElementById('ucINPatientSearch_purposeOfAdmission').value == '0' &&
    document.getElementById('ucINPatientSearch_txtIPNo').value == '' &&
    (document.getElementById('ucINPatientSearch_chkDischarge').checked == false)) {

                alert('Provide at least one search category');
                document.getElementById('ucINPatientSearch_txtPatientNo').focus();
                return false;
            }

            return true;
        }

    </script>--%>
</head>
<body onload="pageLoadFocus('ucINPatientSearch_txtPatientNo');">
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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc112:Header ID="UsrHeader1" runat="server" />
                <uc7:PhyHeader ID="PhyHeader1" runat="server" />
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
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:PatientSearch ID="ucINPatientSearch" runat="server" />
                                </td>
                            </tr>
                            <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Rs_Selectapatientandoneofthefollowing" Text="Select a patient and one of the following"
                                        runat="server"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall" OnSelectedIndexChanged="dList_SelectedIndexChanged">
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
