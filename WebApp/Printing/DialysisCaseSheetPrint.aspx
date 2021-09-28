<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DialysisCaseSheetPrint.aspx.cs"
    Inherits="Dialysis_DialysisCaseSheetPrint" EnableViewState="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="Treatment"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/DialysisOnFlow.ascx" TagName="OnFlowDialysis"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrinting" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/DialysisCaseSheet.ascx" TagName="DialysisCaseSheet"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/RakshithBillPrint.ascx" TagName="RakshithBillPrint"
    TagPrefix="uc13" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" enableviewstate="false">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Dialysis CaseSheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function PopUps() {
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=CR";
               
                window.open(strURL, "", strFeatures, true);
                return false;
            }
    </script>

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
                <uc1:MainHeader ID="OrgHeader" runat="server" />
                <uc13:PatientHeader ID="patientHeader" runat="server" />
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
                    <div class="contentdata">
                        <table width="100%" enableviewstate="false">
                            <tr>
                                <td align="center">
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td align="center">
                                                <p class="pagebreakhere">
                                                    &nbsp;<uc11:DialysisCaseSheet ID="DialysisCaseSheet1" runat="server" />
                                                    </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlBillPrint" runat="server" 
                                                    meta:resourcekey="pnlBillPrintResource1">
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td align="center">
                                                <uc9:BillPrinting ID="billprinting1" runat="server" Mode="PrintMode" EnableViewState="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <uc13:RakshithBillPrint ID="rakshithbillPrint" runat="server" />
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td align="right" nowrap="nowrap">
                                                            <asp:Button ID="btnPrint" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="return PopUps()" 
                                                                runat="server" meta:resourcekey="btnPrintResource1" />
                                                            <asp:Button ID="btnHome" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnHome_Click" runat="server" 
                                                                meta:resourcekey="btnHomeResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc12:Footer ID="Footer" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
