<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintRaksithDischarge.aspx.cs" Inherits="InPatient_PrintRaksithDischarge" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

      <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;" >
                                 <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                
                               <tr>
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 20px" align="center">
                                       <u> <asp:Label ID="lblTypeOfDis" runat="server" 
                                            meta:resourcekey="lblTypeOfDisResource1" ></asp:Label></u>
                                      <u>   <asp:Label ID="lblDischargeTypeName" runat="server" 
                                            meta:resourcekey="lblDischargeTypeNameResource1"></asp:Label></u>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" style="font-size:15px">
                                            <tr >
                                                <td  nowrap="nowrap">
                                                    <asp:Label ID="lblNameT" runat="server" Text="NAME" Font-Italic="True" 
                                                        Font-Bold="True" meta:resourcekey="lblNameTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap" >
                                                    <asp:Label ID="lblNameV" runat="server" meta:resourcekey="lblNameVResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblAgeSexT" runat="server" Text="AGE/SEX" Font-Italic="True" 
                                                        Font-Bold="True" meta:resourcekey="lblAgeSexTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblAgeSexV" runat="server" 
                                                        meta:resourcekey="lblAgeSexVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDOAT" runat="server" Text="DATE OF ADMISSION" 
                                                        Font-Italic="True" Font-Bold="True" meta:resourcekey="lblDOATResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDOAV" runat="server" meta:resourcekey="lblDOAVResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDODT" runat="server" Text="DATE OF DISCHARGE"  
                                                        Font-Italic="True" Font-Bold="True" meta:resourcekey="lblDODTResource1"></asp:Label>
                                                </td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:Label ID="lblDODV" runat="server" meta:resourcekey="lblDODVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPIDT" runat="server" Text="PATIENT NO"  Font-Italic="True" 
                                                        Font-Bold="True" meta:resourcekey="lblPIDTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPIDV" runat="server" meta:resourcekey="lblPIDVResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblIPNOT" runat="server" Text="IP NO" Font-Italic="True"  
                                                        Font-Bold="True" meta:resourcekey="lblIPNOTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblIPNOV" runat="server" meta:resourcekey="lblIPNOVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblUnitT" runat="server" Text="UNIT/WARD" Font-Italic="True" 
                                                        Font-Bold="True" meta:resourcekey="lblUnitTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblUnitV" runat="server" meta:resourcekey="lblUnitVResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblConsultantT" runat="server" Text="CONSULTANT" 
                                                        Font-Italic="True"  Font-Bold="True" meta:resourcekey="lblConsultantTResource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblConsultantV" runat="server" 
                                                        meta:resourcekey="lblConsultantVResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       <hr style="color: Black; height: 0.5px;" />
                                    </td>
                                </tr>                                
                                <tr id="trDiagnosis" runat="server" style="display: none;" >
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="font-size:15px">
                                            <tr>
                                                
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lbldiag" runat="server" Text="DIAGNOSIS" Font-Underline="True"  
                                                        Font-Italic="True" Font-Bold="True" meta:resourcekey="lbldiagResource1" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px; font-size:15px">
                                                    <asp:Table ID="tbldiagnosis" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tbldiagnosisResource1"  >
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lblProcedures" runat="server" Text="PROCEDURES"  
                                                        Font-Italic="True" Font-Underline="True" Font-Bold="True" 
                                                        meta:resourcekey="lblProceduresResource1" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px" >
                                                    <asp:Literal ID="ltrProcedureDesc" runat="server" 
                                                        meta:resourcekey="ltrProcedureDescResource1"  ></asp:Literal>
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lblHistory" runat="server" Text="SHORT HISTORY"  
                                                        Font-Italic="True" Font-Bold="True" Font-Underline="True" 
                                                        meta:resourcekey="lblHistoryResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px" >
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
                                <tr id="trGeneralExamination" runat="server" style="display: none"  >
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="font-size:15px">
                                            <tr>
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lblonExam" runat="server" Text="ON EXAMINATION" Font-Bold="True" 
                                                        Font-Italic="True" Font-Underline="True" meta:resourcekey="lblonExamResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td style="padding-left:5px">
                                           <asp:Label ID="lblADMV" runat="server" meta:resourcekey="lblADMVResource1" ></asp:Label>
                                            </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px; ">
                                                    <asp:Table ID="tblGeneralExam" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblGeneralExamResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px">
                                                    <asp:Table ID="tblSystamaticExamination" runat="server" CellSpacing="0" 
                                                        meta:resourcekey="tblSystamaticExaminationResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>                                            
                                            <tr id="trNegativeExam" runat="server" style="display: none">
                                                <td  style="padding-left:5px; font-size:15px;">
                                                    <asp:Label ID="lblGeneralExam" runat="server" 
                                                        meta:resourcekey="lblGeneralExamResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr  style="font-size:15px">
                                    <td style=" color: #000; padding-bottom:5px; padding-top:5px;">
                                        <asp:Label ID="lblInv" runat="server" Text="INVESTIGATION REPORTS" 
                                            Font-Italic="True" Font-Bold="True" Font-Underline="True" meta:resourcekey="lblInvResource1"
                                            ></asp:Label>
                                        <asp:Label ID="Rs_Enclosed" Text=":Enclosed" runat="server" 
                                            meta:resourcekey="Rs_EnclosedResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                  <tr id="trplan" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                               
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="Label5" runat="server" Text="SURGERY DETAILS" Font-Bold="True" 
                                                        Font-Italic="True" Font-Underline="True" meta:resourcekey="Label5Resource1" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblSurgeryDetail" runat="server" CellSpacing="0" CellPadding="5" 
                                                        meta:resourcekey="tblSurgeryDetailResource1">
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                                <td style="color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lblCIH" runat="server" Text="COURSE IN THE HOSPITAL" 
                                                        Font-Italic="True" Font-Bold="True" Font-Underline="True" 
                                                        meta:resourcekey="lblCIHResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: Black; padding-left:3px; font-size:15px" >
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                                <td style=" color: #000; padding-bottom:5px;">
                                                    <asp:Label ID="lblCOD" runat="server" Text="CONDITION ON DISCHARGE" 
                                                        Font-Italic="True" Font-Bold="True" Font-Underline="True" 
                                                        meta:resourcekey="lblCODResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: Black; padding-left:3px ;font-size:15px" >
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
                                <tr id="trAdvice" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                            <tr>
                                                <td style=" color: #000;">
                                                    <asp:Label ID="lblDA" runat="server" Text="DISCHARGE ADVICE" Font-Italic="True" 
                                                        Font-Bold="True" Font-Underline="True" meta:resourcekey="lblDAResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px; font-size:15px" >
                                                    <asp:Table ID="tblprescription" runat="server" CellSpacing="5" 
                                                        style="font-size:15px" meta:resourcekey="tblprescriptionResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left:5px ">
                                                    <asp:Table ID="tblAdvice" runat="server" CellSpacing="0" style="font-size:15px" 
                                                        Width="26px" meta:resourcekey="tblAdviceResource1">
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
                          <%--       <tr id="trADMV" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Label5" runat="server" Text="ADMISSION VITALS" Font-Underline="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td style="padding-left:5px">
                                           <asp:Label ID="lblADMV" runat="server" ></asp:Label>
                                            </td>
                                            </tr>
                                           
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>--%>
                                   <tr  style="font-size:15px">
                                    <td style=" color: #000;">
                                       
                                         <asp:Label ID="Label6" Font-Bold="True" Font-Italic="True" 
                                             Font-Underline="True" runat="server" Text=" NEXT REVIEW -" 
                                             meta:resourcekey="Label6Resource1"></asp:Label>
                                        <asp:Label ID="lblNextReview" Font-Bold="True"  runat="server" 
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
                            <table cellpadding="0" cellspacing="0" border="0" width="100%"  style="font-size:15px">
                                <tr>
                                    <td style="width: 9%;">
                                        <asp:Label ID="lblSMO" runat="server" meta:resourcekey="lblSMOResource1" ></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblCI" runat="server" meta:resourcekey="lblCIResource1" ></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 9%;">
                                        <asp:Label ID="Label4" runat="server" Text="DUTY MEDICAL OFFICER" 
                                            Font-Bold="True" Font-Italic="True" meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="Label3" runat="server" Text=" CONSULTANT INCHARGE" 
                                            Font-Bold="True" Font-Italic="True" meta:resourcekey="Label3Resource1"></asp:Label>
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
                                    <td style="width: 9%;font-size:15px">
                                        <asp:Label ID="Label2" runat="server" Text="PREPARED BY:" Font-Bold="True" 
                                            Font-Italic="True" meta:resourcekey="Label2Resource1"></asp:Label>
                                        <asp:Label ID="lblPreparedBy" runat="server" 
                                            meta:resourcekey="lblPreparedByResource1"></asp:Label>
                                    </td>
                                    <td width="20%" align="center" style="font-size:15px">
                                        <asp:Label ID="Label1" runat="server" Text="TYPED BY:" Font-Bold="True" 
                                            Font-Italic="True" meta:resourcekey="Label1Resource1"></asp:Label>
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
                          
    </form>
</body>
</html>

 <script language="javascript" type="text/javascript">
    
     window.print();
     window.focus();
</script>
