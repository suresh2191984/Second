<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewIPCaseSheet.aspx.cs" Inherits="Physician_ViewIPCaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Register Src="../DischargeSummary/Musculoskeletal.ascx" TagName="Musculoskeletal"
    TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Case Sheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function PrintIPCaseSheet() {

            var prtContent = document.getElementById('PrintDischarge');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            WinPrint.close();
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="5%" valign="top" id="menu" style="display: block;">
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <div class="contentdata">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div id="PrintDischarge">
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;" class="defaultfontcolor">
                                <%-- <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>--%>
                                <tr class="defaultfontcolor">
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                                        <asp:Label ID="Rs_ADMISSIONNOTES" Text="CASE SHEET" runat="server" meta:resourcekey="Rs_ADMISSIONNOTESResource1"></asp:Label>
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
                                <tr id="trCSB" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_CaseSeenby" Text="Case Seen by -" runat="server" meta:resourcekey="Rs_CaseSeenbyResource1"></asp:Label>
                                        <asp:Label ID="lblCSB" runat="server" meta:resourcekey="lblCSBResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOA" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_DateTimeofAdmission" Text="Date & Time of Admission -" runat="server"
                                            meta:resourcekey="Rs_DateTimeofAdmissionResource1"></asp:Label>
                                        <asp:Label ID="lblDOA" runat="server" meta:resourcekey="lblDOAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trAccompaniedBy" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_AccompaniedBy" Text="Accompanied By -" runat="server" meta:resourcekey="Rs_AccompaniedByResource1"></asp:Label>
                                        <asp:Label ID="lblAccompaniedBy" runat="server" meta:resourcekey="lblAccompaniedByResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
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
                                                    <asp:Table ID="tblBackgroundProblems" runat="server" CellSpacing="0" BorderWidth="0px"
                                                        GridLines="Both" meta:resourcekey="tblBackgroundProblemsResource1">
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
                                <tr id="trAdmissionVitals" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_ADMISSIONVITALS" Text="ADMISSION VITALS" runat="server" meta:resourcekey="Rs_ADMISSIONVITALSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblAdmissionVitals" runat="server" CellSpacing="0" BorderWidth="1px"
                                                        CellPadding="8" GridLines="Both" meta:resourcekey="tblAdmissionVitalsResource1">
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
                                                    <asp:Table ID="tblGeneralExam" runat="server" CellSpacing="0" meta:resourcekey="tblGeneralExamResource1"
                                                        Width="26px">
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
                                                    <uc6:Musculoskeletal ID="Musculoskeletal1" runat="server" />
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
                                <tr id="trInvOrdered" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_INVESTIGATIONORDERED" Text="INVESTIGATION ORDERED" runat="server"
                                                        meta:resourcekey="Rs_INVESTIGATIONORDEREDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblInvOrdered" runat="server" CellSpacing="0" meta:resourcekey="tblInvOrderedResource1">
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
                                                    <asp:Label ID="Rs_PROVISIONALDIAGNOSIS" Text="PROVISIONAL DIAGNOSIS" runat="server"
                                                        meta:resourcekey="Rs_PROVISIONALDIAGNOSISResource1"></asp:Label>
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
                                <tr>
                                    <td>
                                        <uc5:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
                                    </td>
                                </tr>
                                <tr id="trplan" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_TREATMENTPLAN" Text="TREATMENT PLAN" runat="server" meta:resourcekey="Rs_TREATMENTPLANResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblPlan" runat="server" CellSpacing="4" BorderWidth="0px" GridLines="Both"
                                                        meta:resourcekey="tblPlanResource1">
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
                                <tr id="trPrescription" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PRESCRIPTION" Text="PRESCRIPTION" runat="server" meta:resourcekey="Rs_PRESCRIPTIONResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblprescription" runat="server" CellSpacing="0" CellPadding="7" BorderWidth="1px"
                                                        GridLines="Both" meta:resourcekey="tblprescriptionResource1">
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
                                <tr id="trAdvice" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tbladvice" runat="server" meta:resourcekey="tbladviceResource1">
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
                                <tr id="trNextReviewDate" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblNewReviewDate" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblNewReviewDateResource1">
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
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" 
                                        OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
