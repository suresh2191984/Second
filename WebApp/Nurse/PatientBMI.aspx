<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientBMI.aspx.cs" Inherits="PatientBMI" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PatientBMI.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient BMI</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>
     <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                        <table cellpadding="0" cellspacing="0" width="50%" class="defaultfontcolor" align="center">
                            <tr id="trVType" style="display: none;" runat="server">
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Label1" runat="server" Text="Select A Type" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlVitalsType" runat="server" TabIndex="10" CssClass ="ddlsmall"
                                        meta:resourcekey="ddlVitalsTypeResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td height="32" colspan="2" align="left">
                                    <uc2:PatientVitalsControl ID="patientvitals" runat="server" />
                                    &nbsp;
                                </td>
                            </tr>
                            <%--<tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblText" Text="Patient Condition" runat="server"></asp:Label>
                                </td>
                                <td >
                                    <asp:DropDownList ID="ddPatientCondition" runat="server" TabIndex="8">
                                    </asp:DropDownList>
                                </td>
                            </tr>--%>
                            <%--<tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblComments" Text="Comments" runat="server"></asp:Label>
                                </td>
                                <td >
                                    <asp:TextBox Rows="4" ID="txtComments" Columns="28" runat="server" MaxLength="1000"
                                        TextMode="MultiLine" TabIndex="9"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblselect" runat="server" Text="Select Option to Perform"></asp:Label>
                                    <asp:DropDownList ID="drpOption" runat="server" TabIndex="10" >
                                    </asp:DropDownList>
                                </td>
                            </tr>         --%>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnFinish" runat="server" Text="Finish" CssClass="btn" 
                                        OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" 
                                        OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1" />
                                    <%--<asp:Button ID="btnFinish" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" TabIndex="10" Text="Finish" onClientClick='return checkSelection();'
                                        OnClick="btnFinish_Click" />                                 
                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" TabIndex="11"  Text="Cancel" 
                                        OnClick="btnCancel_Click" />--%>
                                    <asp:HiddenField runat="server" ID="hdnVistType" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
         <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
