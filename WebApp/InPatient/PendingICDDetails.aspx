<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingICDDetails.aspx.cs"
    Inherits="InPatient_PendingICDDetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PendingICDCode.ascx" TagName="PendingICDCode"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Pending ICD Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <input type="hidden" id="hdnDiagnosisItems" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
   <ContentTemplate>--%>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                        <table align="center" width="50%">
                            <tr>
                                <td>
                                    <ul>
                                        <li id="liOP" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnOP" runat="server" Text="Operation Notes" OnClick="lbtnOP_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="PowderBlue" 
                                                meta:resourcekey="lbtnOPResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="liAN" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnAN" runat="server" Text="Case Sheet" OnClick="lbtnAN_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="LightSlateGray" 
                                                meta:resourcekey="lbtnANResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="li1DSY" runat="server" style="display: none;">
                                            <asp:LinkButton ID="LinkDSY" runat="server" Text="Discharge Summary" OnClick="LinkDSY_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="LightGreen" 
                                                meta:resourcekey="LinkDSYResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="liDeath" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnDeath" runat="server" Text="Death Summary" OnClick="lbtnDeath_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="Gray" 
                                                meta:resourcekey="lbtnDeathResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="liNNN" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnNNN" runat="server" Text="Neonatal Notes" OnClick="lbtnNNN_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="Cyan" 
                                                meta:resourcekey="lbtnNNNResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="liDVN" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnDVN" runat="server" Text="Delivery Notes" OnClick="lbtnDVN_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="Aqua" 
                                                meta:resourcekey="lbtnDVNResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                        <li id="liPDI" runat="server" style="display: none;">
                                            <asp:LinkButton ID="lbtnPDI" runat="server" Text="Patient Diagnose" OnClick="lbtnPDI_Click"
                                                Font-Underline="True" Font-Bold="True" ForeColor="Pink" 
                                                meta:resourcekey="lbtnPDIResource1"></asp:LinkButton>
                                        </li>
                                            &nbsp;&nbsp;
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table id="tblICDOPIP" align="left" class="dataheaderInvCtrl defaultfontcolor" width="100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Rs_FilterByICDStatus" Text="Filter By ICD Status:" 
                                                runat="server" meta:resourcekey="Rs_FilterByICDStatusResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" 
                                                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" 
                                                meta:resourcekey="ddlStatusResource1">
                                                <asp:ListItem Value="All" Text="All" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Value="Pending" Text="Pending" 
                                                    meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Value="Completed" Text="Completed" 
                                                    meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                <asp:ListItem Value="Ignored" Text="Ignored" 
                                                    meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblMsg" runat="server" Text="No Records Found" Font-Bold="True" 
                                                Visible="False" meta:resourcekey="lblMsgResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <uc2:PendingICDCode ID="PendingICDCodePCT" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <uc2:PendingICDCode ID="PendingICDCodeBP" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <uc2:PendingICDCode ID="PendingICDCodePCN" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Save ICD Codes" 
                                                meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
                                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <%-- </ContentTemplate>
      </asp:UpdatePanel>--%>
    </form>
</body>
</html>
