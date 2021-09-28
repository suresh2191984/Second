<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DischargeSummaryCaseSheet.aspx.cs"
    Inherits="Physician_DischargeSummaryCaseSheet" meta:resourcekey="PageResource1" %>

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
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Discharge Summary CaseSheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>
     <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function PrintDischargeSheet() {


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


        function pValidationDischarge() {

            if (document.getElementById("pid").value == '') {
           var  userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummaryCaseSheet.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
               alert('Select a discharge summary to view');
                return false;
            }
        }

    </script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>
    <style type="text/css">
        .style2
        {
            height: 19px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="tblDischargeDetail" cellpadding="0" cellspacing="0" border="0" width="100%"
                            style="display: block" runat="server">
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;" colspan="2" align="center">
                                                <input type="hidden" id="pid" name="pid" />
                                                <asp:GridView ID="gvDischargeDetail" runat="server" AutoGenerateColumns="False" DataKeyNames="PatientVistID"
                                                    OnRowDataBound="gvDischargeDetail_RowDataBound" meta:resourcekey="gvDischargeDetailResource1">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect"
                                                                    meta:resourcekey="rdSelResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPatientVistID" runat="server" Text='<%# Bind("DateOfDischarge") %>'
                                                                    meta:resourcekey="lblDateOfDischargeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date Of Discharge" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDateOfDischarge" runat="server" Text='<%# Bind("PatientVistID") %>'
                                                                    meta:resourcekey="lblPatientVistIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Diagnosis" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDiagnosis" runat="server" meta:resourcekey="lblDiagnosisResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Surgery / Procedure" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSurgery" runat="server" meta:resourcekey="lblSurgeryResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Physician" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysician" runat="server" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:Button ID="btnEditDischrageDetails" runat="server" Text="Edit / Print Discharge Summary "
                                                    CssClass="btn" OnClientClick="return pValidationDischarge()" OnClick="btnEditDischrageDetails_Click"
                                                    meta:resourcekey="btnEditDischrageDetailsResource1" />
                                                <asp:Button ID="btnEditOperationCancel" runat="server" Text="Cancel" CssClass="btn"
                                                    meta:resourcekey="btnEditOperationCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div id="PrintDischarge">
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 0%" align="center">
                                <tr>
                                    <td align="center">
                                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label Style="font-family: Verdana; font-size: 12px;" ID="lblHospitalName" runat="server"
                                            Font-Bold="True" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;">
                                <%-- <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>--%>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <hr style="color: Black; height: 0.5px;" />
                                    </td>
                                </tr>
                                <tr id="trTitle" runat="server" style="display: none">
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
                                        <strong>
                                            <asp:Label ID="Rs_DateTimeofAdmission" Text="Date & Time of Admission :" runat="server"
                                                meta:resourcekey="Rs_DateTimeofAdmissionResource1"></asp:Label></strong>
                                        <asp:Label ID="lblDOA" runat="server" meta:resourcekey="lblDOAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOS" runat="server" style="display: none">
                                    <td>
                                        <strong>
                                            <asp:Label ID="Rs_DateTimeofSurgery" Text="Date & Time of Surgery :" runat="server"
                                                meta:resourcekey="Rs_DateTimeofSurgeryResource1"></asp:Label></strong>
                                        <asp:Label ID="lblDOS" runat="server" meta:resourcekey="lblDOSResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOD" runat="server" style="display: none">
                                    <td>
                                        <strong>
                                            <asp:Label ID="Rs_DateTimeofDischarge" Text="Date & Time of Discharge :" runat="server"
                                                meta:resourcekey="Rs_DateTimeofDischargeResource1"></asp:Label></strong>
                                        <asp:Label ID="lblDOD" runat="server" meta:resourcekey="lblDODResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trTOD" runat="server" style="display: none">
                                    <td>
                                        <strong>
                                            <asp:Label ID="Rs_TypeofDischarge" Text="Type of Discharge :" runat="server" meta:resourcekey="Rs_TypeofDischargeResource1"></asp:Label></strong>
                                        <asp:Label ID="lblTOD" runat="server" meta:resourcekey="lblTODResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trConsultant" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblConsultantT" runat="server" Text="Primary Consultant :" Font-Bold="True"
                                            meta:resourcekey="lblConsultantTResource1"></asp:Label>
                                        <asp:Label ID="lblConsultant" runat="server" meta:resourcekey="lblConsultantResource1"></asp:Label>
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
                                            <tr id="trAddress" runat="server" style="display: none">
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_ADDRESS" Text="ADDRESS" runat="server" meta:resourcekey="Rs_ADDRESSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr valign="top" id="tdPermenantAddress" runat="server" style="display: none">
                                                <td valign="top" width="30%">
                                                    <asp:Label ID="Rs_PermenantAddress" Text="Permenant Address:" runat="server" meta:resourcekey="Rs_PermenantAddressResource1"></asp:Label>
                                                    <br />
                                                    <asp:Table ID="tblPermenantAddress" runat="server" CellSpacing="0" meta:resourcekey="tblPermenantAddressResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr id="tdPresentAddress" runat="server" style="display: none">
                                                <td>
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
                                <tr id="trCOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblCOD" runat="server" Text="CONDITION ON DISCHARGE" meta:resourcekey="lblCODResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: Black; padding-left: 3px">
                                                    <asp:Label ID="lblCODV" runat="server" ForeColor="Black" meta:resourcekey="lblCODVResource1"></asp:Label>
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
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <uc5:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
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
                                            <tr id="trNegativeHistory" runat="server" style="display: none">
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
                                                    <asp:Table ID="tblgeneralExamination" runat="server" CellSpacing="0" BorderWidth="0px"
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
                                            <tr id="trNegativeExam" runat="server" style="display: none">
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
                                                    <asp:Table ID="tbDischargeVitals" runat="server" CellSpacing="0" BorderWidth="0px"
                                                        CellPadding="8" meta:resourcekey="tbDischargeVitalsResource1">
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
                                                    <asp:Repeater ID="repTreatmentPlan" runat="server" OnItemDataBound="repTreatmentPlan_ItemDataBound">
                                                        <ItemTemplate>
                                                            <asp:Table ID="tblSOI" Width="100%" runat="server" meta:resourcekey="tblSOIResource1">
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource1">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource1">
                                                                        <asp:Label ID="lblTreatmentNameT" runat="server" Text="Treatment Name:" meta:resourcekey="lblTreatmentNameTResource1"></asp:Label>
                                                                        <asp:Label ID="lblTreatmentName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TreatmentName") %>'
                                                                            meta:resourcekey="lblTreatmentNameResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource2">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource2">
                                                                        <asp:Label ID="lblFromTimeT" runat="server" Text="Treatment Date:" meta:resourcekey="lblFromTimeTResource1"></asp:Label>
                                                                        <asp:Label ID="lblFromTime" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTime") %>'
                                                                            meta:resourcekey="lblFromTimeResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource3">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource3">
                                                                        <asp:Label ID="lblAnesthesiaTypeT" runat="server" Text="Anesthesia Type:" meta:resourcekey="lblAnesthesiaTypeTResource1"></asp:Label>
                                                                        <asp:Label ID="lblAnesthesiaType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "AnesthesiaType") %>'
                                                                            meta:resourcekey="lblAnesthesiaTypeResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource4">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource4">
                                                                        <asp:Label ID="lblSurgeryTypeT" runat="server" Text="Surgery Type:" meta:resourcekey="lblSurgeryTypeTResource1"></asp:Label>
                                                                        <asp:Label ID="lblSurgeryType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SurgeryType") %>'
                                                                            meta:resourcekey="lblSurgeryTypeResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource5">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource5">
                                                                        <asp:Label ID="lblOperationTypeT" runat="server" Text="Operation Type:" meta:resourcekey="lblOperationTypeTResource1"></asp:Label>
                                                                        <asp:Label ID="lblOperationType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperationType") %>'
                                                                            meta:resourcekey="lblOperationTypeResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource6">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource6">
                                                                        <asp:Label ID="lblOperationFindingsT" runat="server" Text="Operation Findings:" meta:resourcekey="lblOperationFindingsTResource1"></asp:Label>
                                                                        <asp:Label ID="lblOperationFindings" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperativeFindings") %>'
                                                                            meta:resourcekey="lblOperationFindingsResource1"></asp:Label>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow runat="server" meta:resourcekey="TableRowResource7">
                                                                    <asp:TableCell runat="server" meta:resourcekey="TableCellResource7">
                                                                        <asp:Label ID="lblOperativeTechniqueT" runat="server" Text="Operative Technique:"
                                                                            meta:resourcekey="lblOperativeTechniqueTResource1"></asp:Label>
                                                                        <asp:Label ID="lblOperativeTechnique" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OperativeTechnique") %>'
                                                                            meta:resourcekey="lblOperativeTechniqueResource1"></asp:Label>
                                                                        <br />
                                                                        <br />
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%-- <tr>
                                <td><asp:Table ID="tblS" Width="100%" runat="server">
                                
                                
                                </asp:Table>
                                </td>
                               
                                </tr>--%>
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
                                <tr id="trAdvice" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_ADVICE" Text="ADVICE" runat="server" meta:resourcekey="Rs_ADVICEResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblAdvice" runat="server" CellSpacing="0" meta:resourcekey="tblAdviceResource1">
                                                    </asp:Table>
                                                    <asp:Label ID="Rs_Info2" Text="Report to hospital in case of the following issues:"
                                                        runat="server" meta:resourcekey="Rs_Info2Resource1"></asp:Label><br />
                                                    <li type="a">
                                                        <asp:Label ID="Rs_Info3" Text="High grade fever (&gt;103 degree Fahrenheit)" runat="server"
                                                            meta:resourcekey="Rs_Info3Resource1"></asp:Label></li><br />
                                                    <li type="a">
                                                        <asp:Label ID="Rs_Info4" Text="Giddiness, decreased level of consciousness and/or altered mentation"
                                                            runat="server" meta:resourcekey="Rs_Info4Resource1"></asp:Label></li><br />
                                                    <li type="a">
                                                        <asp:Label ID="Rs_Info5" Text="Difficulty in breathing, chest pain and/or profuse sweating"
                                                            runat="server" meta:resourcekey="Rs_Info5Resource1"></asp:Label></li><br />
                                                    <li type="a">
                                                        <asp:Label ID="Rs_Info6" Text="Urinary retention, decreased urine output, leg swelling, nausea and/or
                                                                    loss of appetite" runat="server" meta:resourcekey="Rs_Info6Resource1"></asp:Label></li><br />
                                                    <li type="a">
                                                        <asp:Label ID="Rs_Operatedsitebleedingorinfection" Text="Operated site bleeding or infection"
                                                            runat="server" meta:resourcekey="Rs_OperatedsitebleedingorinfectionResource1"></asp:Label></li>
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
                                    <td class="style2">
                                        <asp:Label ID="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILE" Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)"
                                            runat="server" meta:resourcekey="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILEResource1"></asp:Label>
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
                                        <asp:Label ID="lblSMO" runat="server" Visible="False" meta:resourcekey="lblSMOResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCI" runat="server" Visible="False" meta:resourcekey="lblCIResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="lblSMOT" runat="server" Text="Senior Medical Officer" Visible="False"
                                            meta:resourcekey="lblSMOTResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCIT" runat="server" Text="Consultant Incharge" Visible="False"
                                            meta:resourcekey="lblCITResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%" id="tdPreparedBy" runat="server">
                                        <asp:Label ID="lblPreparedByT" runat="server" Text="Prepared By:" Visible="False"
                                            meta:resourcekey="lblPreparedByTResource1"></asp:Label>
                                        <asp:Label ID="lblPreparedBy" runat="server" Visible="False" meta:resourcekey="lblPreparedByResource1"></asp:Label>
                                    </td>
                                    <td width="30%" align="center" id="tdTyped" runat="server">
                                        <asp:Label ID="lblTypedByT" runat="server" Text="Typed By:" Visible="False" meta:resourcekey="lblTypedByTResource1"></asp:Label><asp:Label
                                            ID="lblTypedBy" runat="server" Visible="False" meta:resourcekey="lblTypedByResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintDischargeSheet();"
                                        value="Print" class="btn" runat="server" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click"
                                        meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
         <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
    <%--<p>
        &lt;li id=&quot;li1DSY&quot; runat=&quot;server&quot;&gt; &lt;asp:LinkButton ID=&quot;LinkDSY&quot;
        runat=&quot;server&quot; Text=&quot;Discharge Summary&quot; onclick=&quot;LinkDSY_Click&quot;
        &gt;&lt;/asp:LinkButton&gt; &lt;/li&gt;</p>--%>
</body>
</html>
