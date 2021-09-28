<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeathCaseSheet.aspx.cs" Inherits="InPatient_DeathCaseSheet" meta:resourcekey="PageResource1" %>

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
    <title>Death Summary</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
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

    <style type="text/css">
        .style2
        {
            height: 19px;
        }
        #btnPrint
        {
            width: 55px;
        }
    </style>

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
                                <top:topheader id="TopHeader1" runat="server" />
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
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 0%" align="center">
                                <tr>
                                    <td align="center">
                                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                                            meta:resourcekey="imgBillLogoResource1" />
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
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblNeonatalSheet"
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
                                <tr>
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                                        <asp:Label ID="lblNeonatal" runat="server" Text="Death Summary" 
                                            meta:resourcekey="lblNeonatalResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPatientDetail" runat="server" Font-Bold="True" 
                                            meta:resourcekey="lblPatientDetailResource1"></asp:Label>
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
                                                    <asp:Label ID="Label4" runat="server" Text="ADDRESS" 
                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr valign="top" id="tdPermenantAddress" runat="server" style="display: none">
                                                <td valign="top" width="30%">
                                                    <asp:Label ID="Rs_PermenantAddress" Text="Permenant Address:" runat="server" 
                                                        meta:resourcekey="Rs_PermenantAddressResource1"></asp:Label>
                                                    <br />
                                                    <asp:Table ID="tblPermenantAddress" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblPermenantAddressResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr id="tdPresentAddress" runat="server" style="display: none">
                                                <td>
                                                    <asp:Label ID="Rs_PresentAddress" Text="Present Address:" runat="server" 
                                                        meta:resourcekey="Rs_PresentAddressResource1"></asp:Label><br />
                                                    <asp:Table ID="tblPresentAddress" runat="server" CellSpacing="0" Width="26px" 
                                                        meta:resourcekey="tblPresentAddressResource1">
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
                                <tr id="trDOA" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblDOAH" runat="server" Text="Date Of Admission :" 
                                            Font-Bold="True" meta:resourcekey="lblDOAHResource1"></asp:Label>
                                        <asp:Label ID="lblDOA" runat="server" meta:resourcekey="lblDOAResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOS" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblDOSH" runat="server" Text="Date Of Surgery :" 
                                            Font-Bold="True" meta:resourcekey="lblDOSHResource1"></asp:Label>
                                        <asp:Label ID="lblDOS" runat="server" meta:resourcekey="lblDOSResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOD" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblDODH" runat="server" Text="Date Of Death :" Font-Bold="True" 
                                            meta:resourcekey="lblDODHResource1"></asp:Label>
                                        <asp:Label ID="lblDOD" runat="server" meta:resourcekey="lblDODResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trPOC" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Place Of Occurrence :" 
                                            Font-Bold="True" meta:resourcekey="Label1Resource1"></asp:Label>
                                        <asp:Label ID="lblPOC" runat="server" meta:resourcekey="lblPOCResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trTODS" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Type Of Death :" Font-Bold="True" 
                                            meta:resourcekey="Label2Resource1"></asp:Label>
                                        <asp:Label ID="lblTOD" runat="server" meta:resourcekey="lblTODResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trPCON" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="lblPCONH" runat="server" Text="Primary Consultant :" 
                                            Font-Bold="True" meta:resourcekey="lblPCONHResource1"></asp:Label>
                                        <asp:Label ID="lblPCON" runat="server" meta:resourcekey="lblPCONResource1"></asp:Label>
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
                                                <td style="font-weight: bold; color: #000;" class="style2">
                                                    <asp:Label ID="Rs_HISTORY" Text="HISTORY" runat="server" 
                                                        meta:resourcekey="Rs_HISTORYResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblHistory" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblHistoryResource1">
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
                                <tr id="trProc" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_PROCEDURE"  Text="PROCEDURE" runat="server" 
                                                        meta:resourcekey="Rs_PROCEDUREResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Label ID="lblProc" runat="server" meta:resourcekey="lblProcResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trPCOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PRIMARYCAUSEOFDEATH" Text="PRIMARY CAUSE OF DEATH" 
                                                        runat="server" meta:resourcekey="Rs_PRIMARYCAUSEOFDEATHResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblPCOD" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblPCODResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trSCOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_SECONDARYCAUSEOFDEATH" Text="SECONDARY CAUSE OF DEATH" 
                                                        runat="server" meta:resourcekey="Rs_SECONDARYCAUSEOFDEATHResource1"></asp:Label>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblSCOD" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblSCODResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trACOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_ASSOCIATEDILLNESS" Text="ASSOCIATED ILLNESS" runat="server" 
                                                        meta:resourcekey="Rs_ASSOCIATEDILLNESSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblACOD" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblACODResource1" Height="21px" Width="26px">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trBP" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px;">
                                                    <asp:Label ID="Label3" runat="server" Text="BACKGROUND PROBLEM" 
                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trtrTC" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTCH" runat="server" Text="Tobacco Chewing" 
                                                        meta:resourcekey="lblTCHResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTCD" runat="server" meta:resourcekey="lblTCDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trSMK" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblSMKH" runat="server" Text="Smoking" 
                                                        meta:resourcekey="lblSMKHResource1"></asp:Label>
                                                </td>
                                                <td style="padding-left: 50px;">
                                                    <asp:Label ID="lblSMKD" runat="server" meta:resourcekey="lblSMKDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trAL" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblALH" runat="server" Text="Alcohol" 
                                                        meta:resourcekey="lblALHResource1"></asp:Label>
                                                </td>
                                                <td style="padding-left: 60px;">
                                                    <asp:Label ID="lblALD" runat="server" meta:resourcekey="lblALDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trID" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblIDH" runat="server" Text="Illicit drugs" 
                                                        meta:resourcekey="lblIDHResource1"></asp:Label>
                                                </td>
                                                <td style="padding-left: 40px;">
                                                    <asp:Label ID="lblIDD" runat="server" meta:resourcekey="lblIDDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="tr1DAP" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDAP" runat="server" Text="Death Associated With Pregnancy " 
                                                        meta:resourcekey="lblDAPResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblType" runat="server" meta:resourcekey="lblTypeResource1"></asp:Label>
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
                                <tr id="trBackgroundProblem" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="80%">
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblBackgroundProblems" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblBackgroundProblemsResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr id="trNegativeHistory" runat="server" style="display: none">
                                                <td>
                                                    <asp:Label ID="lblBackgroundProblems" runat="server" 
                                                        meta:resourcekey="lblBackgroundProblemsResource1"></asp:Label>
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
                                <tr id="trgeneralExam" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_ADMISSIONVITALS" Text="ADMISSION VITALS" runat="server" 
                                                        meta:resourcekey="Rs_ADMISSIONVITALSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblgeneralExamination" runat="server" CellSpacing="0" BorderWidth="0px"
                                                        CellPadding="8" GridLines="Both" 
                                                        meta:resourcekey="tblgeneralExaminationResource1">
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
                                                   <asp:Label ID="Rs_GENERALEXAMINATION" Text="GENERAL EXAMINATION" runat="server" 
                                                        meta:resourcekey="Rs_GENERALEXAMINATIONResource1"></asp:Label>
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
                                                <td>
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
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                   <asp:Label ID="Rs_COURSEINTHEHOSPITAL" Text="COURSE IN THE HOSPITAL" 
                                                        runat="server" meta:resourcekey="Rs_COURSEINTHEHOSPITALResource1"></asp:Label>
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
                                <%--     <tr id="trRAS" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px;">
                                                    <asp:Label ID="lblRASH" runat="server" Text="RESUSCITATION AND SUPPORT"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="tr1RAS" runat="server" style="display: none">
                                                <td>
                                                    <asp:Label ID="lblRADyes" runat="server" Text="Resuscitation And Support "></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="tr1ROSC" runat="server" style="display: none">
                                                <td>
                                                    <asp:Label ID="lblROSC" runat="server" Text="ROSC"></asp:Label>
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
                                <tr id="trMLC" runat="server" style="display: none">
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="font-weight: bold; height: 20px;">
                                                    <asp:Label ID="lblMLC" runat="server" Text="MLC FORMALITIES "></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblEventLocationH" runat="server" Text="Event Location" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEventLocationD" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEventDateH" runat="server" Text="Event Date" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEventDateD" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblFIRNOH" runat="server" Text="FIR No" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblFIRNOD" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblFIRNDateH" runat="server" Text="FIR Date" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblFIRNDateD" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPSH" runat="server" Text="Police Station" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPSD" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPCH" runat="server" Text="MLC No" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPCD" runat="server"></asp:Label>
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
                                <tr id="trOD" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    ORGAN DONATION
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 30px;">
                                                    <asp:Table ID="tblOD" runat="server" CellSpacing="0" BorderWidth="1px" GridLines="Both">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_Info" Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)" 
                                            runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
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
                            <%--               <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="lblSMO" runat="server"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        <asp:Label ID="lblCI" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        Senior Medical Officer
                                    </td>
                                    <td width="30%" align="center">
                                        Consultant Incharge
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%">
                                        Prepared By:<asp:Label ID="lblPreparedBy" runat="server"></asp:Label>
                                    </td>
                                    <td width="30%" align="center">
                                        Typed By:<asp:Label ID="lblTypedBy" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>--%>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintNeonatalSheet();"
                                        value="Print" class="btn" runat="server" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" 
                                        OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" Width="59px" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" 
                                        Width="76px" />
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
