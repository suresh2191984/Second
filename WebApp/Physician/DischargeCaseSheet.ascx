<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargeCaseSheet.ascx.cs"
    Inherits="Physician_DischargeCaseSheet" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .style2
    {
        height: 135px;
    }
</style>
<table id="tblDischargeDetail" cellpadding="0" cellspacing="0" border="0" width="100%"
    style="display: block" runat="server">
</table>
<div id="PrintDischarge">
    <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
        style="display: block;">
        <%-- <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>--%>
        <tr>
            <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                <asp:Label ID="lblTypeOfDis" runat="server" meta:resourcekey="lblTypeOfDisResource1"></asp:Label>
                <asp:Label ID="lblDischargeTypeName" runat="server" meta:resourcekey="lblDischargeTypeNameResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold; height: 20px;">
                <asp:Label ID="lblPatientDetail" runat="server" meta:resourcekey="lblPatientDetailResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trDOA" runat="server" style="display: none">
            <td>
                <asp:Label ID="Rs_DateTimeofAdmission" Text="Date & Time of Admission -" runat="server"
                    meta:resourcekey="Rs_DateTimeofAdmissionResource1"></asp:Label>
                <asp:Label ID="lblDOA" runat="server" meta:resourcekey="lblDOAResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trDOS" runat="server" style="display: none">
            <td>
                <asp:Label ID="Rs_DateTimeofSurgery" Text="Date & Time of Surgery -" runat="server"
                    meta:resourcekey="Rs_DateTimeofSurgeryResource1"></asp:Label>
                <asp:Label ID="lblDOS" runat="server" meta:resourcekey="lblDOSResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trDOD" runat="server" style="display: none">
            <td>
                <asp:Label ID="Rs_DateTimeofDischarge" Text="Date & Time of Discharge -" runat="server"
                    meta:resourcekey="Rs_DateTimeofDischargeResource1"></asp:Label>
                <asp:Label ID="lblDOD" runat="server" meta:resourcekey="lblDODResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trConsultant" runat="server" style="display: none">
            <td>
                <asp:Label ID="lblConsultantT" runat="server" Text="Consultant" Font-Bold="True"
                    meta:resourcekey="lblConsultantTResource1"></asp:Label>
                -<asp:Label ID="lblConsultant" runat="server" meta:resourcekey="lblConsultantResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_ADDRESS" Text="ADDRESS" runat="server" meta:resourcekey="Rs_ADDRESSResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top" width="30%" id="tdPermenantAddress" runat="server" style="display: none">
                            <asp:Label ID="Rs_PermenantAddress" Text="Permenant Address:" runat="server" meta:resourcekey="Rs_PermenantAddressResource1"></asp:Label><br />
                            <asp:Table ID="tblPermenantAddress" runat="server" CellSpacing="0" meta:resourcekey="tblPermenantAddressResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdPresentAddress" runat="server" style="display: none">
                            <asp:Label ID="Rs_PresentAddress" Text="Present Address:" runat="server" meta:resourcekey="Rs_PresentAddressResource1"></asp:Label><br />
                            <asp:Table ID="tblPresentAddress" runat="server" CellSpacing="0" meta:resourcekey="tblPresentAddressResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trDiagnosis" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_DIAGNOSIS" Text="DIAGNOSIS" runat="server" meta:resourcekey="Rs_DIAGNOSISResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tbldiagnosis" runat="server" CellSpacing="0" meta:resourcekey="tbldiagnosisResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trCPhysician" runat="server" style="display: none">
            <td style="font-weight: bold; height: 15px; color: #000;">
                <asp:Label ID="Rs_PrimaryPhysician" Text="Primary Physician -" runat="server" meta:resourcekey="Rs_PrimaryPhysicianResource1"></asp:Label>
                <asp:Label ID="lblCPhysician" runat="server" meta:resourcekey="lblCPhysicianResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trCSurgeon" runat="server" style="display: none">
            <td style="font-weight: bold; height: 15px; color: #000;">
                <asp:Label ID="Rs_ConsultingSurgeon" Text="Consulting Surgeon -" runat="server" meta:resourcekey="Rs_ConsultingSurgeonResource1"></asp:Label>
                <asp:Label ID="lblCSurgeon" runat="server" meta:resourcekey="lblCSurgeonResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr id="trHistory" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_HISTORY" Text="HISTORY" runat="server" meta:resourcekey="Rs_HISTORYResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblHistory" runat="server" CellSpacing="0" meta:resourcekey="tblHistoryResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Literal ID="ltrDetailHistory" runat="server" meta:resourcekey="ltrDetailHistoryResource1"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trBackgroundProblem" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="80%">
                    <tr>
                        <td style="font-weight: bold; height: 10px; color: #000;">
                            <asp:Label ID="Rs_BACKROUNDMEDICALPROBLEMS" Text="BACKROUND MEDICAL PROBLEMS" runat="server"
                                meta:resourcekey="Rs_BACKROUNDMEDICALPROBLEMSResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblBackgroundProblems" runat="server" CellSpacing="0" meta:resourcekey="tblBackgroundProblemsResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblBackgroundProblems" runat="server" meta:resourcekey="lblBackgroundProblemsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trgeneralExam" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_ADMISSIONVITALS" Text="ADMISSION VITALS" runat="server" meta:resourcekey="Rs_ADMISSIONVITALSResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblgeneralExamination" runat="server" CellSpacing="0" BorderWidth="1px"
                                CellPadding="8" GridLines="Both" meta:resourcekey="tblgeneralExaminationResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trGeneralExamination" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="80%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_GENERALEXAMINATION" Text="GENERAL EXAMINATION" runat="server" meta:resourcekey="Rs_GENERALEXAMINATIONResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblGeneralExam" runat="server" CellSpacing="0" meta:resourcekey="tblGeneralExamResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblGeneralExam" runat="server" meta:resourcekey="lblGeneralExamResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trSystemicExam" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_SYSTEMICEXAMINATION" Text="SYSTEMIC EXAMINATION" runat="server"
                                meta:resourcekey="Rs_SYSTEMICEXAMINATIONResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblSystamaticExamination" runat="server" CellSpacing="0" meta:resourcekey="tblSystamaticExaminationResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trDischargeVitals" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_DISCHARGEVITALS" Text="DISCHARGE VITALS" runat="server" meta:resourcekey="Rs_DISCHARGEVITALSResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tbDischargeVitals" runat="server" CellSpacing="0" BorderWidth="1px"
                                CellPadding="8" GridLines="Both" meta:resourcekey="tbDischargeVitalsResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trSurgery" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_SURGERYPROCEDUREDETAILS" Text="SURGERY / PROCEDURE DETAILS" runat="server"
                                meta:resourcekey="Rs_SURGERYPROCEDUREDETAILSResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- <asp:Table ID="tblSurgery" runat="server" CellSpacing="0" BorderWidth="1" GridLines="Both">
                                    </asp:Table>--%>
                            <asp:Repeater ID="repTreatmentPlan" runat="server" OnItemDataBound="repTreatmentPlan_ItemDataBound">
                                <ItemTemplate>
                                    <asp:Label ID="lblParentName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ParentName") %>'
                                        meta:resourcekey="lblParentNameResource1"></asp:Label>&nbsp;-&nbsp;
                                    <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "IPTreatmentPlanName") %>'
                                        meta:resourcekey="lblIPTreatmentPlanNameResource1"></asp:Label>
                                    <asp:Label ID="lblProsthesis" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Prosthesis") %>'
                                        meta:resourcekey="lblProsthesisResource1"></asp:Label>
                                    Dr.<asp:Label ID="lblPhysicianName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PhysicianName") %>'
                                        meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                    <asp:Label ID="lblFromTime" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTime") %>'
                                        meta:resourcekey="lblFromTimeResource1"></asp:Label>
                                    <br />
                                    Operation Findings:<asp:Label ID="lblOperationFindings" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperationFindings") %>'
                                        meta:resourcekey="lblOperationFindingsResource1"></asp:Label>
                                    <br />
                                    Post Operation Findings<asp:Label ID="lblPostOperationFindings" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PostOperationFindings") %>'
                                        meta:resourcekey="lblPostOperationFindingsResource1"></asp:Label>
                                    <br />
                                    <br />
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trCourseHospital" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_COURSEINTHEHOSPITAL" Text="COURSE IN THE HOSPITAL" runat="server"
                                meta:resourcekey="Rs_COURSEINTHEHOSPITALResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="color: Black;">
                            <asp:Label ID="ltrHospitalcourse" runat="server" ForeColor="Black" meta:resourcekey="ltrHospitalcourseResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trCRCPresc" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td>
                            <asp:Table ID="tblCRCPresc" runat="server" CellSpacing="0" CellPadding="7" meta:resourcekey="tblCRCPrescResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trAdvice" runat="server" style="display: block">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_ADVICE" Text="ADVICE" runat="server" meta:resourcekey="Rs_ADVICEResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                            <asp:Table ID="tblAdvice" runat="server" CellSpacing="0" meta:resourcekey="tblAdviceResource1">
                            </asp:Table>
                            <asp:Label ID="Rs_Info2" Text="Report to hospital in case of the following issues:"
                                runat="server" meta:resourcekey="Rs_Info2Resource1"></asp:Label><br />
                            <li type="a">
                                <asp:Label ID="Rs_Info3" Text="High grade fever (&gt;103 degree Fahrenheit)" runat="server"
                                    meta:resourcekey="Rs_Info3Resource1"></asp:Label><br />
                            </li>
                            <li type="a">
                                <asp:Label ID="Rs_Info4" Text="Giddiness, decreased level of consciousness and/or altered mentation"
                                    runat="server" meta:resourcekey="Rs_Info4Resource1"></asp:Label><br />
                            </li>
                            <li type="a">
                                <asp:Label ID="Rs_Info5" Text="Difficulty in breathing, chest pain and/or profuse sweating"
                                    runat="server" meta:resourcekey="Rs_Info5Resource1"></asp:Label><br />
                            </li>
                            <li type="a">
                                <asp:Label ID="Rs_Info6" Text="Urinary retention, decreased urine output, leg swelling, nausea and/or
                                            loss of appetite" runat="server" meta:resourcekey="Rs_Info6Resource1"></asp:Label><br />
                            </li>
                            <li type="a">O<asp:Label ID="Rs_Info7" Text="perated site bleeding or infection"
                                runat="server" meta:resourcekey="Rs_Info7Resource1"></asp:Label>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trPrescription" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_DISCHARGEPRESCRIPTION" Text="DISCHARGE PRESCRIPTION" runat="server"
                                meta:resourcekey="Rs_DISCHARGEPRESCRIPTIONResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblprescription" runat="server" CellSpacing="0" CellPadding="7" meta:resourcekey="tblprescriptionResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trplan" runat="server" style="display: none">
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td style="font-weight: bold; height: 20px; color: #000;">
                            <asp:Label ID="Rs_PLAN" Text="PLAN" runat="server" meta:resourcekey="Rs_PLANResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Table ID="tblPlan" runat="server" CellSpacing="0" CellPadding="4" meta:resourcekey="tblPlanResource1">
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold; height: 20px; color: #000;">
                <asp:Label ID="Rs_NEXTREVIEW" Text="NEXT REVIEW -" runat="server" meta:resourcekey="Rs_NEXTREVIEWResource1"></asp:Label>
                <asp:Label ID="lblNextReview" runat="server" meta:resourcekey="lblNextReviewResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Rs_Info" Text="Always review with a scheduled appointment from the front office counter for us
                to serve you better." runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Rs_Info1" Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)" runat="server"
                    meta:resourcekey="Rs_Info1Resource1"></asp:Label>
            </td>
        </tr>
        <%-- <tr>
                                <td align="center" colspan="4">
                                                                <asp:Button ID="btnFinish" runat="server" Text="Print" OnClientClick="javascript:" CssClass="btn"  />

                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintDischargeSheet();"
                                        value="Print" class="btn" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" />
                                </td>
                            </tr>--%>
    </table>
</div>
