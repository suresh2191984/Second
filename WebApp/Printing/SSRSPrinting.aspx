<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SSRSPrinting.aspx.cs" Inherits="Printing_SSRSPrinting" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Label</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .style3
        {
            width: 377px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server">
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
                        <table cellpadding="8" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td  colspan="8">
                                 <asp:Panel id="panelDispatchMode" runat="server"  CssClass="dataheaderInvCtrl" Width="100%" Font-Bold="true"  >  
                                <table cellpadding="8" cellspacing="0" border="0" width="100%">
                                 <tr>
                                <td  colspan="8">               
                                    <input id="rdLabel1" type="radio" name="label" runat="server" checked value="1" /><label
                                        id="lblLabel1" runat="server"><asp:Label ID="Rs_CaseNoteSticker" 
                                        Text="Case Note Sticker" runat="server" 
                                        meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>
                                    <input id="rdLabel2" type="radio" name="label" runat="server" value="2" /><label
                                        id="lblLabel2" runat="server"><asp:Label ID="Rs_AddressSticker" 
                                        Text="Address Sticker"  runat="server" 
                                        meta:resourcekey="Rs_AddressStickerResource1"></asp:Label></label>
                                    <input id="rdLabel3" type="radio" name="label" runat="server" value="3" /><label
                                        id="lblLabel3" runat="server"><asp:Label ID="Rs_LabSticker" 
                                        Text="Lab Sticker" runat="server" meta:resourcekey="Rs_LabStickerResource1"></asp:Label></label>
                               
                                   <input id="rdDispatchSticker" type="radio" name="label" runat="server" value="4" /><label
                                        id="Label4" runat="server"><asp:Label ID="Rs_DispatchSticker" 
                                        Text="Dispatch Sticker" runat="server" meta:resourcekey="Rs_DispatchStickerResource1"></asp:Label></label>
                                 
                                  <input id="rdRadiology" type="radio" name="label" runat="server" value="5" /><label
                                        id="Label5" runat="server"><asp:Label ID="Rs_RadiologySticker" 
                                        Text="Radiology / Sonology  Sticker" runat="server" 
                                        meta:resourcekey="Rs_RadiologyStickerResource1"></asp:Label></label>
                                  <span style="white-space:nowrap">
                                   <input id="rdHealthCheckUp" type="radio" name="label" runat="server" value="6" /><label
                                        id="Label16" runat="server"><asp:Label ID="Rs_HealthCheckUpSticker"  
                                        Text="Health Check Up Sticker" runat="server" 
                                        meta:resourcekey="Rs_HealthCheckUpStickerResource1"></asp:Label></label> </span>
                                       
                                </td>
                                </tr>
                                <tr>
                                <td colspan="8">
                                   <input id="rdHomeDispatch" type="radio" name="label" runat="server" value="7" /><label
                                        id="Label7" runat="server"><asp:Label ID="Rs_HomeDispatchSticker" 
                                        Text="Home Dispatch Sticker" runat="server" meta:resourcekey="Rs_HomeDispatchStickerResource1"></asp:Label></label>
                                       
                                   <input id="rdDoctorDispatch" type="radio" name="label" runat="server" value="8" /><label
                                        id="Label8" runat="server"><asp:Label ID="Rs_DoctorDispatchSticker" 
                                        Text="Doctor Dispatch Sticker" runat="server" meta:resourcekey="Rs_DoctorDispatchStickerResource1"></asp:Label></label>
                                        <span style="white-space:nowrap">
                                          <input id="rdECGorStress" type="radio" name="label" runat="server" value="9" /><label
                                        id="Label9" runat="server"><asp:Label ID="Rs_ECGorStress" 
                                        Text="ECG / Stress Test Sticker" runat="server" meta:resourcekey="Rs_ECGorStressResource1"></asp:Label></label></span>
                                
                                
                                 </td>
                                </tr>
                                </table> 
                                </asp:Panel> 
                                </td>
                                </tr>
                                <tr>
                                <td>
                                    <asp:Button ID="btnGo" ToolTip="Click here to View Label" Style="cursor: pointer;"
                                        runat="server" Text="View Label" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" 
                                        meta:resourcekey="btnGoResource1" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <rsweb:ReportViewer ID="rReportViewer" runat="server" 
                            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt"  
                            meta:resourcekey="rReportViewerResource1">
                            <ServerReport ReportServerUrl="" />
                        </rsweb:ReportViewer>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
