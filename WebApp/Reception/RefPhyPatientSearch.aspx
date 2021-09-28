<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefPhyPatientSearch.aspx.cs" Inherits="Reception_RefPhyPatientSearch" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<%@ Register Src="../CommonControls/RefPhysicianPatSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
    
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else
            {
            alert('URL Not Found');
            return false ;
            }
         
           return true;
        }

        function CheckPatientSearch() {

            if (document.getElementById('uctlPatientSearch_txtPatientNo').value == '' && document.getElementById('uctlPatientSearch_txtPatientName').value == '' &&
    document.getElementById('uctlPatientSearch_txtDOB').value == '' && document.getElementById('uctlPatientSearch_txtRelation').value == '' &&
    document.getElementById('uctlPatientSearch_txtLocation').value == '' && document.getElementById('uctlPatientSearch_txtOthers').value == '' && document.getElementById('uctlPatientSearch_txtURNo').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\RefPhyPatientSearch.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else { alert('Provide any one search category'); }
                document.getElementById('uctlPatientSearch_txtPatientNo').focus();
                return false;
            }

            if (document.getElementById('uctlPatientSearch_txtOthers').value != '') {
                if (document.getElementById('uctlPatientSearch_ddOthers').value == -1) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\RefPhyPatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert('Select others');
                    }
                    document.getElementById('uctlPatientSearch_ddOthers').focus();
                    return false;
                }
            }
            return true;
        }

    </script>

</head>
<body onload="pageLoadFocus('uctlPatientSearch_txtPatientNo');" oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnNoLog">
    <div id="wrapper">
        <div id="header">
            <div class="logowrapper">
                <img alt="" src="<%=LogoPath%>" class="logostyle" />
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="UsrHeader1" runat="server" />
                <uc7:PhyHeader ID="PhyHeader1" runat="server" />
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
                            <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                               <asp:Label ID="lbselectpat" runat="server" 
                                        Text="Select a patient and one of the following" 
                                        meta:resourcekey="lbselectpatResource1"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlTheme" 
                                        OnSelectedIndexChanged="dList_SelectedIndexChanged" 
                                        meta:resourcekey="dListResource1">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                    <input id="btnNoLogout" runat="server" style="display: none" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" 
            meta:resourcekey="btnNoLogResource1" />
    </div>
    </form>
</body>
</html>
