<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientSearch.aspx.cs" Inherits="Nurse_PatientSearch"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

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
    document.getElementById('uctlPatientSearch_txtLocation').value == '' && document.getElementById('uctlPatientSearch_txtOthers').value == '' && document.getElementById('uctlPatientSearch_txtURNo').value == '' && document.getElementById('uctlPatientSearch_ddlNationality').value == '0' && document.getElementById('uctlPatientSearch_ddlRegisterDate').value == '-1' && document.getElementById('uctlPatientSearch_txtSmartCardNo').value == '') {
            var  userMsg = SListForApplicationMessages.Get('Nurse\\PatientSearch.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                alert('Provide at least one search category');
                return false ;
                }
                document.getElementById('uctlPatientSearch_txtPatientNo').focus();
                return false;
            }
            if (document.getElementById('uctlPatientSearch_txtOthers').value != '') {
                if (document.getElementById('uctlPatientSearch_ddOthers').value == -1) {
                  var  userMsg = SListForApplicationMessages.Get('Nurse\\PatientSearch.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                    alert('Select value in others');
                    return false ;
                    }
                    document.getElementById('uctlPatientSearch_ddOthers').focus();
                    return false;
                }
            }
            if (document.getElementById('uctlPatientSearch_ddlRegisterDate').value == '3') {
                if (document.getElementById('uctlPatientSearch_txtFromPeriod').value == '' || document.getElementById('uctlPatientSearch_txtToPeriod').value == '') {
                   var  userMsg = SListForApplicationMessages.Get('Nurse\\PatientSearch.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                    alert('Select Date');
                    return false;
                    }
                }
            }
            return true;
        }

    </script>

</head>
<body onload="pageLoadFocus('uctlPatientSearch_txtPatientNo');" oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server" defaultbutton="bGo">
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
                <uc3:Header ID="NurseHeader" runat="server" />
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
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblError" runat="server" Font-Size="X-Small" ForeColor="Red" meta:resourcekey="lblErrorResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td height="32">
                                    <uc2:PatientSearch ID="uctlPatientSearch" runat="server" />
                                </td>
                            </tr>
                            <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Rs_Info" Text="Select a patient and one of the following" runat="server"
                                        meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server" CssClass ="ddlsmall" meta:resourcekey="dListResource1">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Go" OnClick="bGo_Click" meta:resourcekey="bGoResource1" />
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
