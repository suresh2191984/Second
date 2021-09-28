<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargeSummaryR.ascx.cs"
    Inherits="InPatient_DischargeSummaryR" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
<style type="text/css">
   
</style>
 <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;">
                                <tr>
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 20px" align="center">
                                        <asp:Label ID="lblTypeOfDis" runat="server" 
                                            meta:resourcekey="lblTypeOfDisResource1"></asp:Label>
                                        <asp:Label ID="lblDischargeTypeName" runat="server" 
                                            meta:resourcekey="lblDischargeTypeNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td width="120px" nowrap="nowrap">
                                                    <asp:Label ID="lblNameT" runat="server" Text="NAME" Font-Bold="True" 
                                                        meta:resourcekey="lblNameTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblNameV" runat="server" meta:resourcekey="lblNameVResource1"></asp:Label>
                                                </td>
                                                <td width="120px" nowrap="nowrap">
                                                    <asp:Label ID="lblAgeSexT" runat="server" Text="AGE/SEX" Font-Bold="True" 
                                                        meta:resourcekey="lblAgeSexTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAgeSexV" runat="server" 
                                                        meta:resourcekey="lblAgeSexVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDOAT" runat="server" Text="DATE OF ADMISSION" 
                                                        Font-Bold="True" meta:resourcekey="lblDOATResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDOAV" runat="server" meta:resourcekey="lblDOAVResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDODT" runat="server" Text="DATE OF DISCHARGE" 
                                                        Font-Bold="True" meta:resourcekey="lblDODTResource1"></asp:Label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:Label ID="lblDODV" runat="server" meta:resourcekey="lblDODVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPIDT" runat="server" Text="PATIENT NO" Font-Bold="True" 
                                                        meta:resourcekey="lblPIDTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPIDV" runat="server" meta:resourcekey="lblPIDVResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblIPNOT" runat="server" Text="IP NO" Font-Bold="True" 
                                                        meta:resourcekey="lblIPNOTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblIPNOV" runat="server" meta:resourcekey="lblIPNOVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblUnitT" runat="server" Text="UNIT/WARD" Font-Bold="True" 
                                                        meta:resourcekey="lblUnitTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblUnitV" runat="server" meta:resourcekey="lblUnitVResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblConsultantT" runat="server" Text="CONSULTANT" 
                                                        Font-Bold="True" meta:resourcekey="lblConsultantTResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblConsultantV" runat="server" 
                                                        meta:resourcekey="lblConsultantVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <hr />
                                    </td>
                                </tr>
                                
                                <tr id="trDiagnosis" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblDiagnosis" runat="server" Text="DIAGNOSIS" 
                                                        Font-Underline="True" meta:resourcekey="lblDiagnosisResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tbldiagnosis" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tbldiagnosisResource1">
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
                                <tr id="trProcedure" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblProcedures" runat="server" Text="Procedures" 
                                                        Font-Underline="True" meta:resourcekey="lblProceduresResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px">
                                                    <asp:Literal ID="ltrProcedureDesc" runat="server" 
                                                        meta:resourcekey="ltrProcedureDescResource1"></asp:Literal>
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
                                <tr id="trHistory" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblHistory" runat="server" Text="SHORT HISTORY" 
                                                        Font-Underline="True" meta:resourcekey="lblHistoryResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Literal ID="ltrDetailHistory" runat="server" 
                                                        meta:resourcekey="ltrDetailHistoryResource1"></asp:Literal>
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblonExam" runat="server" Text="ON EXAMINATION" 
                                                        Font-Underline="True" meta:resourcekey="lblonExamResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td>
                                         <%--  <asp:Label ID="lblVitals" runat="server" ></asp:Label>--%>
                                          <asp:Label ID="lblADMV" runat="server" meta:resourcekey="lblADMVResource1" ></asp:Label>
                                            </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblGeneralExam" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblGeneralExamResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblSystamaticExamination" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblSystamaticExaminationResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td style="padding-left:5px">
                                                    <asp:Label ID="lblGeneralExam" runat="server" 
                                                        meta:resourcekey="lblGeneralExamResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 20px; color: #000;">
                                        <asp:Label ID="lblInv" runat="server" Text="INVESTIGATION REPORTS" Font-Underline="True"
                                            Font-Bold="True" meta:resourcekey="lblInvResource1"></asp:Label>
                                        <asp:Label ID="Rs_Enclosed" Text=":Enclosed" runat="server" 
                                            meta:resourcekey="Rs_EnclosedResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trCourseHospital" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblCIH" runat="server" Text="COURSE IN THE HOSPITAL" 
                                                        Font-Underline="True" meta:resourcekey="lblCIHResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: Black;">
                                                    <asp:Label ID="ltrHospitalcourse" runat="server" ForeColor="Black" 
                                                        meta:resourcekey="ltrHospitalcourseResource1"></asp:Label>
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
                                <tr id="trCOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblCOD" runat="server" Text="CONDITION ON DISCHARGE" 
                                                        Font-Underline="True" meta:resourcekey="lblCODResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: Black; padding-left:3px" >
                                                    <asp:Label ID="lblCODV" runat="server" ForeColor="Black" 
                                                        meta:resourcekey="lblCODVResource1"></asp:Label>
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
                                                    <asp:Label ID="lblDA" runat="server" Text="DISCHARGE ADVICE" 
                                                        Font-Underline="True" meta:resourcekey="lblDAResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblprescription" runat="server" 
                                                        meta:resourcekey="tblprescriptionResource1" >
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <asp:Table ID="tblAdvice" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblAdviceResource1">
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
                                        <asp:Label ID="Rs_NEXTREVIEW" Text="NEXT REVIEW -" runat="server" 
                                            meta:resourcekey="Rs_NEXTREVIEWResource1"></asp:Label>
                                        <asp:Label ID="lblNextReview" runat="server" 
                                            meta:resourcekey="lblNextReviewResource1"></asp:Label>
                                    </td>
                                </tr> 
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td style="width: 9%;">
                                        <asp:Label ID="lblSMO" runat="server" meta:resourcekey="lblSMOResource1"></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblCI" runat="server" meta:resourcekey="lblCIResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 9%;">
                                        <asp:Label ID="Label4" runat="server" Text="SENIOR MEDICAL OFFICER" 
                                            Font-Bold="True" meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="Label3" runat="server" Text=" CONSULTANT INCHARGE" 
                                            Font-Bold="True" meta:resourcekey="Label3Resource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 9%;">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 9%;">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 9%;">
                                        <asp:Label ID="Label2" runat="server" Text="PREPARED BY:" Font-Bold="True" 
                                            meta:resourcekey="Label2Resource1"></asp:Label>
                                        <asp:Label ID="lblPreparedBy" runat="server" 
                                            meta:resourcekey="lblPreparedByResource1"></asp:Label>
                                    </td>
                                    <td width="20%" align="center">
                                        <asp:Label ID="Label1" runat="server" Text="TYPED BY:" Font-Bold="True" 
                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                        <asp:Label ID="lblTypedBy" runat="server" 
                                            meta:resourcekey="lblTypedByResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                <td>
                                &nbsp;
                                </td>
                                </tr>
                            </table>
