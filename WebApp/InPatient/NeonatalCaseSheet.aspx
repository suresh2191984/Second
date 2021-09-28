<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NeonatalCaseSheet.aspx.cs"
    Inherits="InPatient_NeonatalCaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Neonatal Summary</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function PrintNeonatalSheet() {


            var prtContent = document.getElementById('NeonatalSheet');

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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div id="NeonatalSheet">
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblNeonatalSheet"
                                style="display: block;">
                                <%-- <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>--%>
                                <tr>
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                                        <asp:Label ID="lblNeonatal" runat="server" Text="Neonatal Notes" 
                                            meta:resourcekey="lblNeonatalResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; height: 20px;">
                                        <asp:Label ID="lblPatientDetail" runat="server" 
                                            meta:resourcekey="lblPatientDetailResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOA" runat="server" style="display: none">
                                    <td>
                                       <asp:Label ID="Rs_DATETIMEOFBIRTH"  Text="DATE&TIMEOFBIRTH -" runat="server" 
                                            meta:resourcekey="Rs_DATETIMEOFBIRTHResource1"></asp:Label><asp:Label ID="lblDOA" runat="server" 
                                            meta:resourcekey="lblDOAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trBriefHistory" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_BRIEFHISTORY" Text="BRIEF HISTORY" runat="server" 
                                                        meta:resourcekey="Rs_BRIEFHISTORYResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblBriefHistory" 
                                                        meta:resourcekey="lblBriefHistoryResource1"></asp:Label>
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
                                <tr id="trDeliveryType" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; color: #000; width: 199px;">
                                                    <asp:Label ID="Rs_DELIVERYTYPE" Text="DELIVERY TYPE" runat="server" 
                                                        meta:resourcekey="Rs_DELIVERYTYPEResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblDeliveryType" 
                                                        meta:resourcekey="lblDeliveryTypeResource1"></asp:Label>
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
                                <tr id="trProcedureType" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; color: #000; width: 199px;">
                                                    <asp:Label ID="Rs_ELECTIVEEMERGENCY" Text="ELECTIVE / EMERGENCY" runat="server" 
                                                        meta:resourcekey="Rs_ELECTIVEEMERGENCYResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblProcedureType" 
                                                        meta:resourcekey="lblProcedureTypeResource1"></asp:Label>
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
                                <tr id="trDeliveryTerm" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; color: #000; width: 199px;">
                                                    <asp:Label ID="Rs_DELIVERYTERM" Text="DELIVERY TERM" runat="server" 
                                                        meta:resourcekey="Rs_DELIVERYTERMResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblDeliveryTerm" 
                                                        meta:resourcekey="lblDeliveryTermResource1"></asp:Label>
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
                                <tr id="trBirthweight" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; color: #000; width: 199px;">
                                                    <asp:Label ID="Rs_BIRTHWEIGHT" Text="BIRTH WEIGHT" runat="server" 
                                                        meta:resourcekey="Rs_BIRTHWEIGHTResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblBirthweight" 
                                                        meta:resourcekey="lblBirthweightResource1"></asp:Label>
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
                                <tr id="trAPGAR" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; color: #000; width: 199px;">
                                                    <asp:Label ID="Rs_APGAR" Text="APGAR" runat="server" 
                                                        meta:resourcekey="Rs_APGARResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblAPGAR" meta:resourcekey="lblAPGARResource1"></asp:Label>
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
                                <tr id="trRiskFactor" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_RISKFACTOR" Text="RISK FACTOR" runat="server" 
                                                        meta:resourcekey="Rs_RISKFACTORResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblRiskFactor" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblRiskFactorResource1">
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
                                                    <asp:Label ID="Rs_VITALS" Text="VITALS" runat="server" 
                                                        meta:resourcekey="Rs_VITALSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tbDischargeVitals" runat="server" CellSpacing="0" BorderWidth="1px"
                                                        CellPadding="8" GridLines="Both" 
                                                        meta:resourcekey="tbDischargeVitalsResource1">
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
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trGeneralExamination" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_GENERALEXAMINATION" Text="GENERAL EXAMINATION" runat="server" 
                                                        meta:resourcekey="Rs_GENERALEXAMINATIONResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label ID="lblGeneralExam" runat="server" 
                                                        meta:resourcekey="lblGeneralExamResource1"></asp:Label>
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
                                                    <asp:Label ID="Rs_SYSTEMICEXAMINATION" Text="SYSTEMIC EXAMINATION" 
                                                        runat="server" meta:resourcekey="Rs_SYSTEMICEXAMINATIONResource1"></asp:Label>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblSystamaticExamination" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblSystamaticExaminationResource1">
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
                                <tr id="trCourseHospital" runat="server" style="display: none">
                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                        <asp:Label ID="Rs_NEONATALCOURSECOURSEINTHEHOSPITAL" 
                                            Text="NEONATAL COURSE /COURSE IN THE HOSPITAL" runat="server" 
                                            meta:resourcekey="Rs_NEONATALCOURSECOURSEINTHEHOSPITALResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trResSupport" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_RESPIRATORYSUPPORT" Text="RESPIRATORY SUPPORT" runat="server" 
                                                        meta:resourcekey="Rs_RESPIRATORYSUPPORTResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblResSupport" 
                                                        meta:resourcekey="lblResSupportResource1"></asp:Label>
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
                                <tr id="trFliuds" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_FLIUDSANDNUTRITION" Text="FLIUDS AND NUTRITION" 
                                                        runat="server" meta:resourcekey="Rs_FLIUDSANDNUTRITIONResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblFliuds" meta:resourcekey="lblFliudsResource1"></asp:Label>
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
                                <tr id="trGeneralCourse" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_GENERALCOURSE" Text="GENERAL COURSE" runat="server" 
                                                        meta:resourcekey="Rs_GENERALCOURSEResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblGeneralCourse" 
                                                        meta:resourcekey="lblGeneralCourseResource1"></asp:Label>
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
                                <tr id="trIMUH" runat="server" style="display: none">
                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                        <asp:Label ID="Rs_IMMUNIZATIONOTHERPROPHYLAXIS" 
                                            Text="IMMUNIZATION/OTHER PROPHYLAXIS" runat="server" 
                                            meta:resourcekey="Rs_IMMUNIZATIONOTHERPROPHYLAXISResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trIMUD" runat="server" style="display: none">
                                    <td style="padding-left: 30px;">
                                        <asp:Table ID="tblIMU" runat="server" CellSpacing="0" 
                                            meta:resourcekey="tblIMUResource1">
                                        </asp:Table>
                                    </td>
                                </tr>
                                <tr id="trPrescription" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PRESCRIPTION"  Text="PRESCRIPTION" runat="server" 
                                                        meta:resourcekey="Rs_PRESCRIPTIONResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblprescription" runat="server" CellSpacing="0" CellPadding="7" 
                                                        meta:resourcekey="tblprescriptionResource1">
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
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trAdvice" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_ADVICE" Text="ADVICE" runat="server" 
                                                        meta:resourcekey="Rs_ADVICEResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
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
                                <tr id="trPlan" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PLAN" Text="PLAN" runat="server" 
                                                        meta:resourcekey="Rs_PLANResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label runat="server" ID="lblPlan" meta:resourcekey="lblPlanResource1"></asp:Label>
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
                                        <asp:Label ID="Rs_Info" Text="Always review with a scheduled appointment from the front office counter for us
                                        to serve you better."  runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILE" 
                                            Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)" runat="server" 
                                            meta:resourcekey="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILEResource1"></asp:Label>
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
                                    <td width="30%">
                                        <asp:Label ID="lblSMO" runat="server" meta:resourcekey="lblSMOResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCI" runat="server" meta:resourcekey="lblCIResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="Rs_SeniorMedicalOfficer" Text="Senior Medical Officer" 
                                            runat="server" meta:resourcekey="Rs_SeniorMedicalOfficerResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="Rs_ConsultantIncharge" Text="Consultant Incharge" runat="server" 
                                            meta:resourcekey="Rs_ConsultantInchargeResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        <asp:Label  ID="Rs_PreparedBy" Text="Prepared By:" runat="server" 
                                            meta:resourcekey="Rs_PreparedByResource1"></asp:Label>
                                        <asp:Label ID="lblPreparedBy" runat="server" 
                                            meta:resourcekey="lblPreparedByResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID ="Rs_TypedBy" Text="Typed By:" runat="server" 
                                            meta:resourcekey="Rs_TypedByResource1"></asp:Label>
                                        <asp:Label ID="lblTypedBy" runat="server" 
                                            meta:resourcekey="lblTypedByResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintNeonatalSheet();"
                                        value="Print" class="btn" runat="server" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" 
                                        OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
