<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintViewCounsellingDetails.aspx.cs"
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

    <script type="text/css">
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


        function PrintCounsellingCaseSheet() {

            var prtContent = document.getElementById('printdiv');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            //WinPrint.close();
        }


    </script>

    <style type="text/css">
        .style1
        {
            width: 169px;
        }
        .style2
        {
            height: 23px;
        }
        .style3
        {
            width: 171px;
        }
        .style4
        {
            width: 256px;
        }
        .style5
        {
            width: 224px;
        }
    </style>
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
                                <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" 
                                    runat="server" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                            </li>
                        </ul>
                        <div id="printdiv">
                            <table width="100%" id="tdCounsellingCaseShhet2" style="font-family: Tahoma;">
                                <tr style="width: 100">
                                    <td width="100%" style="height: 50%;">
                                        <asp:Label ID="lblCounselling" Text="Error in Loading Case Sheet" 
                                            runat="server" meta:resourcekey="lblCounsellingResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" style="font-family: Tahoma;">
                                            <tr id="trreivew" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label ID="lblReview" runat="server" meta:resourcekey="lblReviewResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" style="font-family: Tahoma;">
                                            <tr align="left">
                                                <td id="tdExam" runat="server" style="display: none;">
                                                    <b><u>PSYCHIATRY EXAMINATION </u></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblExam" runat="server" meta:resourcekey="lblExamResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" style="height: auto;">
                                            <tr>
                                                <td>
                                                    <uc6:PrintHistory ID="PrintHistory1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" id="Table1" style="font-family: Tahoma;">
                                            <tr>
                                                <td>
                                                    <uc5:PrintExam ID="PrintExam1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table style="width: 75%;">
                            <tr align="center">
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintCounsellingCaseSheet();"
                                        value="Print" class="btn" runat="server" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" 
                                        meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnHome" runat="server" Text="Ok" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnHome_Click" 
                                        meta:resourcekey="btnHomeResource1" />
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
