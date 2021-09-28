<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TreatmentProcedure.aspx.cs"
    Inherits="Dialysis_TreatmentProcedure" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="procedures"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry() {
            if (document.getElementById('procedures_ddlProcedureName').options[document.getElementById('procedures_ddlProcedureName').selectedIndex].innerHTML == '---Select---') {
                alert('Select the type of treatment procedure');
                document.getElementById('procedures_ddlProcedureName').focus();
                return false;
            }
            document.getElementById('btnSave').style.display = 'none';
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                        <ul id="dvErrorDisplay" runat="server" style="display: none;">
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td>
                                    <div class="dataheader2">
                                        <div id="divTreatmentBill">
                                            &nbsp;<uc8:procedures ID="procedures" runat="server" />
                                        </div>
                                        <br />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="dataheader2">
                                        <br />
                                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnSave" Enabled="False" runat="server" Text="Save"
                                            CssClass="btn" OnClientClick="return avoiddoubleentry();" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnSave_Click" 
                                            meta:resourcekey="btnSaveResource1" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                            meta:resourcekey="btnCancelResource1" />
                                        <br />
                                        <br />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
