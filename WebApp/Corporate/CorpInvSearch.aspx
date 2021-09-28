<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CorpInvSearch.aspx.cs" Inherits="Corporate_CorpInvSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/CorporatePatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register src="../CommonControls/IPClientTpaInsurance.ascx" tagname="IPClientTpaInsurance" tagprefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ValidatePatientName() {

            if (document.getElementById("uctlPatientSearch_hdnPatientID").value == '') {

                alert('Select patient name');
                return false;
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnSearch1">
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
                                    <tr runat="server" id="divClients" style="display: none;">
                                        <td runat="server">
                                           
                                            <uc7:IPClientTpaInsurance ID="IPClientTpaInsurance1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td>
                                            <asp:Label ID="lblloctaion" Text="Location" runat="server" 
                                                meta:resourcekey="lblloctaionResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlLocatiopn" runat="server" meta:resourcekey="ddlLocatiopnResource1" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="aRow" runat="server">
                                        <td id="Td1" class="defaultfontcolor" runat="server">
                                            <asp:Label ID="Rs_Selectapatient" Text="Select a patient and perform one of the following"
                                                runat="server" />
                                            <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                            <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" OnClientClick="return ValidatePatientName()"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="bGo_Click" />
                                            <asp:Button ID="btnSearch1" Visible="False" CssClass="btn" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
    </div>
    </form>
</body>
</html>
