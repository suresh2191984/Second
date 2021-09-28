<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintViewEMRPackages.aspx.cs"
    Inherits="Patient_PrintViewEMRPackages" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="uc5" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/FeesEntry.ascx" TagName="Billing" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/InvestigationReportViewer.ascx" TagName="InvReport"
    TagPrefix="ucInvReport" %>
<%@ Register Src="../EMR/PrintDiagnostics.ascx" TagName="PrintDiagnostics" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script  type="text/css">
                .TabDisplay { 
                    display: block !important; 
                    visibility: visible !important; 
                    margin-top: 10px; 
                    border: 1px solid #900; 
                }
    </script>
    <script language="javascript" type="text/javascript">
    
        function popupprint() {
            var prtContent = document.getElementById('printdiv');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }
        




    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata" id="divMain">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                        </table>
                        <div id="printdiv">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <uc6:PrintHistory ID="PrintHistory1" runat="server" />
                                        <uc5:PrintExam ID="PrintExam1" runat="server" />
                                        <uc7:PrintDiagnostics Visible="false" ID="PrintDiagnostics1" runat="server" />
                                        <ucInvReport:InvReport ID="InvestigationReportViewer" Visible="false" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table style="width: 75%;">
                            <tr align="center">
                                <td>
                                    <uc8:Billing ID="billing" runat="server" Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Button ID="btnEdit" Visible="false" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnSaveExit" Visible="false" runat="server" Text="Save & Exit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSaveExit_Click" />
                                    <asp:Button ID="btnsavecont" Visible="false" runat="server" Text="Save & Continue" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnsavecontinue_Click" />
                                    <asp:Button ID="btnPatientRecomendation" runat="server" Text="Enter PatientRecommendation"
                                        CssClass="btn" Visible="false" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClick="btnPatientRecomendation_Click" meta:resourcekey="btnPatientRecomendationResource1" />
                                    <%--<input type="button" visible ="false" id='btnprint' value='Print' onclick='popupprint();' CssClass="btn" Visible="false" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                                    <%-- <asp:Button ID="btnPrint" runat ="server" Text ="Print" OnClientClick="popupprint();" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer" runat="server" />
    </div>
    </form>
    
</body>
</html>
