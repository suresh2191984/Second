<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.aspx.cs" Inherits="Patient_PatientDetails"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientDetails.ascx" TagName="PatientDetails" TagPrefix="uc6" %>
<%@ Register Src="EventChart.ascx" TagName="EventChart" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/PatientExamination.ascx" TagName="PatientExamination"
    TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/PatientHistory.ascx" TagName="PatientHistory"
    TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/PatientInvestigation.ascx" TagName="PatientInvestigation"
    TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/PatientTreatment.ascx" TagName="PatientTreatment"
    TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/PrintPrescription.ascx" TagName="PrintPrescription"
    TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc13" %>
<%@ Register Src="~/CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc14" %>
<%@ Register Src="~/CommonControls/PatientPrescription.ascx" TagName="Treatment"
    TagPrefix="uc15" %>
<%@ Register Src="~/CommonControls/Receipt.ascx" TagName="Receipt" TagPrefix="uc16" %>
<%@ Register Src="~/CommonControls/DialysisOnFlow.ascx" TagName="OnFlowDialysis"
    TagPrefix="uc17" %>
<%@ Register Src="~/CommonControls/DialysisCaseSheet.ascx" TagName="DialysisCaseSheet"
    TagPrefix="uc18" %>
<%@ Register Src="../Physician/DischargeCaseSheet.ascx" TagName="DischargeCaseSheet"
    TagPrefix="uc19" %>
<%@ Register Src="~/ANC/ANCCaseSheet.ascx" TagName="ANCCaseSheet" TagPrefix="uc20" %>
<%@ Register Src="~/CommonControls/PatientOldNotesViewer.ascx" TagName="OldNotesViewer"
    TagPrefix="uc21" %>
<%@ Register Src="~/CommonControls/InvestigationReportViewer.ascx" TagName="InvestigationReportViewer"
    TagPrefix="uc22" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="ucExam" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="ucHis" %>
<%@ Register Src="../EMR/PrintDiagnostics.ascx" TagName="PrintDiagnostics" TagPrefix="ucDiag" %>
<%@ Register Src="../InPatient/NeonatalCaseSheets.ascx" TagName="NeonatalCaseSheets"
    TagPrefix="ucNeonatal" %>
<%@ Register Src="../InPatient/NeonatalCaseSheets.ascx" TagName="NeonatalCaseSheets"
    TagPrefix="ucRdis" %>
<%@ Register Src="../InPatient/DischargeSummaryR.ascx" TagName="DischargeSummaryR"
    TagPrefix="uc23" %>
<%@ Register Src="../DischargeSummary/DischargeCaseSheetDynamic.ascx" TagName="DischargeCaseSheetDynamic"
    TagPrefix="uc24" %>
<%@ Register Src="../CommonControls/EMROPCaseSheet.ascx" TagName="EMROPCasesheet"
    TagPrefix="uc25" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function expandBox(id) {
            document.getElementById(id).rows = "5"
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1"
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc1:PatientHeader ID="Header3" runat="server" />
            </div>
            <div style="float: right" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel runat="server" ID="updatepnl1">
                            <ContentTemplate>
                                <table cellspacing="1" border="0" width="100%">
                                    <tr>
                                        <td align="left" valign="middle" colspan="4" style="padding-top: 1%" runat="server"
                                            id="tdnewconsultation">
                                            <%--<asp:ImageButton ID="ibtnDiagnose" runat="server" ImageUrl="~/Images/newconsultation.png"
                                                OnClick="ibtnDiagnose_Click" Width="130" />--%>
                                            <asp:LinkButton ID="ibtnDiagnose" CssClass="newconsultation" Width="125px" runat="server"
                                                Text="New Consultation" OnClick="ibtnDiagnose_Click" />
                                        </td>
                                        <td align="left" valign="middle" colspan="4" style="padding-top: 1%" runat="server"
                                            id="tdNewOperationNotes">
                                            <asp:Button ID="btnNewOperationNotes" runat="server" Text="New Admission" CssClass="btn"
                                                OnClick="btnNewOperationNotes_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="colorforcontent" width="25%" align="left" runat="server" id="td1" visible="false">
                                            <div style="display: block" id="Div2">
                                                <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" />
                                                <span class="dataheader1txt">Event Details </span>
                                            </div>
                                        </td>
                                        <td>
                                        </td>
                                        <td align="right" colspan="2">
                                            <asp:TextBox ID="txtSearchText" ToolTip="Type Visit Description" runat="server" CssClass="Txtboxsmall" ></asp:TextBox>
                                            <Ajax:AutoCompleteExtender ID="searchText" runat="server" DelimiterCharacters=","
                                                MinimumPrefixLength="2" ServiceMethod="GetData" ServicePath="~/GetEventName.asmx"
                                                TargetControlID="txtSearchText" UseContextKey="true">
                                            </Ajax:AutoCompleteExtender>
                                            <%-- <asp:ImageButton ID="ibtnGo" runat="server" OnClientClick="return isEmptyTxt()" OnClick="ibtnGo_Click"
                                                ImageUrl="~/Images/search.png" />--%>
                                            <asp:LinkButton ID="ibtnGo" CssClass="SearchBtn" Width="80px" runat="server" Text="Search"
                                                OnClientClick="return isEmptyTxt()" OnClick="ibtnGo_Click" />
                                            <asp:LinkButton ID="lnkView" runat="server" ForeColor="Black" OnClick="lnkView_Click"
                                                Text="View All" Visible="false"></asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="4">
                                            <uc5:EventChart ID="EventChart2" runat="server" />
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="4">
                                            <div id="divFckRefLetter" style="display: none;" runat="server">
                                                <FCKeditorV2:FCKeditor ToolbarStartExpanded="false" ToolbarSet="false" ID="fckHospitalCourse"
                                                    runat="server">
                                                </FCKeditorV2:FCKeditor>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="colorforcontent" width="25%" align="left" runat="server" id="tdVisitDetails"
                                            visible="false">
                                            <div style="display: block" id="Div1">
                                                <img src="../Images/hideBids.gif" alt="" width="15" height="15" align="top" />
                                                <span class="dataheader1txt">Visit Details </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr valign="top">
                                                    <td id="tdPHistory" runat="server">
                                                        <uc12:PrintPrescription ID="PrintPrescription" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc13:OPCaseSheet ID="OPCaseSheet" runat="server" />
                                                        <uc25:EMROPCasesheet ID="EMRCaseSheet" runat="server" />
                                                        <uc20:ANCCaseSheet ID="ANCCaseSheet" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc19:DischargeCaseSheet ID="PatientDischrageDetail" runat="server" Visible="false" />
                                                        <uc23:DischargeSummaryR ID="DischargeSummaryR1" runat="server" />
                                                        <uc24:DischargeCaseSheetDynamic ID="DischargeCaseSheetDynamic1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <ucNeonatal:NeonatalCaseSheets ID="NeonatalCaseSheets1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc15:Treatment ID="Treatment" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc16:Receipt ID="Receipt" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc17:OnFlowDialysis ID="onFlowDialysis" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <uc18:DialysisCaseSheet ID="DialysisCaseSheet" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <uc21:OldNotesViewer ID="viewData" runat="server" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <uc22:InvestigationReportViewer ID="InvestigationReportViewer" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%--<ucHis:PrintHistory ID="ucHis" runat="server" Visible="false" />
                                                        <ucExam:PrintExam ID="ucExam" runat="server" Visible="false" />--%>
                                                        <div id="divEMR" runat="server" visible="false">
                                                            <Ajax:TabContainer ID="tcEMR" runat="server" Height="750px" ActiveTabIndex="0" Width="100%">
                                                                <Ajax:TabPanel ID="tpHistory" runat="server" HeaderText="View History">
                                                                    <ContentTemplate>
                                                                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                                            <ContentTemplate>
                                                                                <div id="divCapHis" cssclass="dataheader2" style="height: 750px; overflow: auto;">
                                                                                    <table width="100%" style="height: auto;">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <ucHis:PrintHistory ID="ucHis" runat="server" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </ContentTemplate>
                                                                        </asp:UpdatePanel>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                                <Ajax:TabPanel runat="server" ID="tpExamination" HeaderText="View Examination">
                                                                    <ContentTemplate>
                                                                        <div id="divCapExam" style="height: 750px; overflow: auto;">
                                                                            <table width="100%" style="height: auto;">
                                                                                <tr>
                                                                                    <td>
                                                                                        <ucExam:PrintExam ID="ucExam" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                                <Ajax:TabPanel runat="server" ID="tbDiagnostics" HeaderText="View Diagnostics">
                                                                    <ContentTemplate>
                                                                        <div id="divCapDiagnostics" style="height: 750px; overflow: auto;">
                                                                            <table width="100%" style="height: auto;">
                                                                                <tr>
                                                                                    <td>
                                                                                        <ucDiag:PrintDiagnostics ID="ucDiagnostics" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                                <Ajax:TabPanel runat="server" ID="TabPanel1" HeaderText="Investigation Results">
                                                                    <ContentTemplate>
                                                                        <div id="divInvReport" style="height: 750px; overflow: auto;">
                                                                            <table width="100%" style="height: auto;">
                                                                                <tr>
                                                                                    <td>
                                                                                        <uc22:InvestigationReportViewer ID="EMRinvReport" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                                <Ajax:TabPanel runat="server" ID="tbPatinetRecommendation" HeaderText="Patient Recommendation">
                                                                    <ContentTemplate>
                                                                        <div id="div3" style="height: 500px; overflow: auto;">
                                                                            <table width="100%" style="height: auto;">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:GridView ID="grdResult" Width="87%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                                                            ForeColor="#333333" CssClass="mytable1">
                                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                                            <Columns>
                                                                                                <asp:TemplateField ItemStyle-Width="2%" HeaderText="SNO" HeaderStyle-HorizontalAlign="Left">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbl_SequenceNO" runat="server" Text='<%#Eval("SequenceNO") %>' Font-Size="Small"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="Recommendation">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbl_details" runat="server" Text='<%#Eval("ResultValues") %>' Font-Size="Small"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                                <Ajax:TabPanel runat="server" ID="upLoadViewer" HeaderText="Patient Old Notes">
                                                                    <ContentTemplate>
                                                                        <div id="div4" style="height: 750px; overflow: auto;">
                                                                            <table width="100%" style="height: auto;">
                                                                                <tr>
                                                                                    <td>
                                                                                        <uc21:OldNotesViewer ID="OldNotesViewer1" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </Ajax:TabPanel>
                                                            </Ajax:TabContainer>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers >
                             <asp:PostBackTrigger ControlID="ibtnDiagnose" />
                             </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
