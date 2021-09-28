<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewEMRPackages.aspx.cs"
    Inherits="Patient_ViewEMRPackages" meta:resourcekey="PageResource1" %>

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
    <script language="javascript" type="text/javascript">

        function popupprint() {
            document.getElementById('TablePatientHeader').style.display = 'block';
            document.getElementById('tableSignature').style.display = 'block';
            var prtContent = document.getElementById('divPrintDet');
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
                        <div id="printdiv" runat="server">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <div id="divPrint" style="float: inherit">
                                            <ajc:TabContainer ID="tcEMR" runat="server" style="height:auto;overflow:auto;" 
                                                ActiveTabIndex="3" Width="100%"
                                                meta:resourcekey="tcEMRResource1">
                                                <ajc:TabPanel runat="server" ID="tpHistory" HeaderText="View History" meta:resourcekey="tpHistoryResource1">
                                                    <HeaderTemplate>
                                                        View History
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divCapHis" style="height:auto;overflow:auto;">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <uc6:PrintHistory ID="PrintHistory1" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tpExamination" runat="server" HeaderText="View Examination" meta:resourcekey="tpExaminationResource1">
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divCapExam" style="height:auto;overflow:auto;">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <uc5:PrintExam ID="PrintExam1" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel ID="tbDiagnostics" runat="server" style="height:auto;overflow:auto;" HeaderText="View Diagnostics"
                                                    meta:resourcekey="tbDiagnosticsResource1">
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel3" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divCapDiagnostics" style="height:auto;overflow:auto;">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <uc7:PrintDiagnostics ID="PrintDiagnostics1" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                                <ajc:TabPanel runat="server" ID="TabPanel1" HeaderText="Investigation Results" meta:resourcekey="TabPanel1Resource1">
                                                    <HeaderTemplate>
                                                        Investigation Results
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="updatePanel15" runat="server">
                                                            <ContentTemplate>
                                                                <div id="divInvReport" style="height:auto;overflow:auto;">
                                                                    <table width="100%" style="height: auto;">
                                                                        <tr>
                                                                            <td>
                                                                                <ucInvReport:InvReport ID="InvestigationReportViewer" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                            </ajc:TabContainer>
                                        </div>
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
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnSaveExit" runat="server" Text="Save & Exit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSaveExit_Click" />
                                    <asp:Button ID="btnsavecont" runat="server" Text="Save & Continue" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnsavecontinue_Click" />
                                    <asp:Button ID="btnPatientRecomendation" runat="server" Text="Enter PatientRecommendation"
                                        CssClass="btn" Visible="false" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClick="btnPatientRecomendation_Click" meta:resourcekey="btnPatientRecomendationResource1" />
                                    <input type="btnprint" id="btnPrint" onclick="popupprint();" style="cursor:default;width:25px;height:20px;" value="Print" Class="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        tabindex="0" />
                                    <%--<asp:Button  id="btnPrint"  OnClientClick="popupprint();"  Text="Print" CssClass="btn"  
                                            onmouseover="setCursorByID(this.id,'default');this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" style="height: 20px; width: 29px" runat="server" />--%>
                                    <%--<asp:Button ID="btnprint" runat="server" Text="Print" OnClientClick="popupprint();"
                                        CssClass="btn"  onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                         />--%>
                                    <%--<input type="button" id='btnprint' value='Print' onclick='popupprint();' CssClass="btn" Visible="false" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                                    <%-- <asp:Button ID="btnPrint" runat ="server" Text ="Print" OnClientClick="popupprint();" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <div id="divPrintDet" style="display: none" runat="server">
             <table id="TablePatientHeader" runat="server" style="display: none;" width="100%">
                <tr>
                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
                        align="center" colspan="4">
                        <asp:Label ID="lblPatientHeader" runat="server" Text="PATIENT DETAILS"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table id="tblPatientDetails" runat="server" width="100%">
                            <tr>
                                <td nowrap="nowrap" align="left" >
                                    <asp:Label ID="lblPatientName" runat="server" Text="Name"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblPatientNameValue" runat="server"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRegDateTime" runat="server" Text="Reg. Date/Time"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRegDateTimeValue" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblPermNo" runat="server" Text="Perm No."></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblPermNoValue" runat="server"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblReportedDateTime" runat="server" Text="Reported Date/Time"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblReportedDateTimeValue" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblVisitNo" runat="server" Text="Visit No."></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblVisitNoValue" runat="server"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblPrintedDateTime" runat="server" Text="Printed Date/Time"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblPrintedDateTimeValue" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblGenderAge" runat="server" Text="Gender/Age"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblGenderAgeValue" runat="server"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefClientName" runat="server" Text="Ref. Client"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefClientNameValue" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefDrName" runat="server" Text="Ref. Dr"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefDrNameValue" runat="server"></asp:Label>
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefHospital" runat="server" Text="Ref. Hospital"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td nowrap="nowrap" align="left">
                                    <asp:Label ID="lblRefHospitalValue" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <hr size="5" />

            <uc6:PrintHistory ID="PrintHistory2" runat="server" />
            <uc5:PrintExam ID="PrintExam2" runat="server" />
            <uc7:PrintDiagnostics  ID="PrintDiagnostics2" runat="server" />
            <ucInvReport:InvReport ID="InvReport1" Visible="false" runat="server" />
            <table id="tableSignature" runat="server" style="display: none;" width="100%">
            <tr>
              <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
                        align="right" colspan="4">
                       
                    </td>
             </tr>
              <tr>
              <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
                        align="right" colspan="4">
                        <asp:Label ID="lblSignature" runat="server" Text="Doctor's Signature"></asp:Label>
                    </td>
             </tr>
           </table> 
        </div>
        <uc2:Footer ID="Footer" runat="server" />
    </div>
    </form>
</body>
</html>
