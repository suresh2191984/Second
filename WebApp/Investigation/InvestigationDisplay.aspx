<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationDisplay.aspx.cs"
    Inherits="Investigation_InvestigationDisplay" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="BioChemistryDisplay.ascx" TagName="BioChemistryDisplay" TagPrefix="uc6" %>
<%@ Register Src="HemotologyDisplay.ascx" TagName="HemotologyDisplay" TagPrefix="uc7" %>
<%@ Register Src="ClinicalDisplay.ascx" TagName="ClinicalDisplay" TagPrefix="uc8" %>
<%@ Register Src="MicroBioDiplay.ascx" TagName="MicroBioDiplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%--<%@ Register src="../Reception/Header.ascx" tagname="Header" tagprefix="uc5" %>--%>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc10" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Clinical Pathology</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
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
                <uc2:Header ID="Header2" runat="server" />
                <%--<uc5:Header ID="Header3" runat="server" />     --%>
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc10:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width: 25%; height: 22px;" class="colorforcontent">
                                    <asp:Label ID="lblName" Text="Investigations Performed" runat="server" Font-Size="Larger"
                                        ForeColor="White" meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:CheckBoxList runat="server" ID="chkInvLst" RepeatColumns="3" RepeatDirection="Horizontal"
                                        onclick="return false;" CssClass="defaultfontcolor" 
                                        meta:resourcekey="chkInvLstResource1">
                                    </asp:CheckBoxList>
                                    <asp:GridView ID="grdSampleResults" runat="server" 
                                        meta:resourcekey="grdSampleResultsResource1">
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%; height: 22px;" class="colorforcontent">
                                    <asp:Label ID="lblReport" Text="Investigation Report" runat="server" Font-Size="Larger"
                                        ForeColor="White" meta:resourcekey="lblReportResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="Dmicro" style="display: none">
                                        <uc9:MicroBioDiplay ID="MicroBioDiplay1" runat="server" />
                                    </div>
                                    <div id="DBio" style="display: none">
                                        <uc6:BioChemistryDisplay ID="BioChemistryDisplay1" runat="server" />
                                    </div>
                                    <div id="DClinic" style="display: none">
                                        <uc8:ClinicalDisplay ID="ClinicalDisplay1" runat="server" />
                                    </div>
                                    <div id="DHemat" style="display: none">
                                        <uc7:HemotologyDisplay ID="HemotologyDisplay1" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSave" runat="server" TabIndex="26" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="btnCancel" runat="server" TabIndex="26" Text="Cancel" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
