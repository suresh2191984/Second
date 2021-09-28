<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintHistory.aspx.cs" Inherits="Patient_PrintHistory" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('PrintPackage');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>
    <style type="text/css">
        .style1
        {
            height: 23px;
        }
    </style>
</head>
<body >
    <form id="form1" runat="server"><asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <div id="wrapper">
         <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>                        
                    
                   <table border="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="right" valign="middle">
                                <asp:Button ID="btnEditHis" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="btnEditHis_Click" 
                                    meta:resourcekey="btnEditHisResource1" />&nbsp;&nbsp;<asp:Button 
                                    ID="btnEMRExam" runat="server" Text="Capture Exam" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="btnEMRExam_Click" 
                                    meta:resourcekey="btnEMRExamResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            &nbsp;
                            </td>
                        </tr>
                    </table>
                    <div id="PrintPackage">
                    <table width="100%">
                      <tr> <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                                    <asp:Label ID="Label1" runat="server" Text="MEDICAL HISTORY" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                            </tr>
                    </table>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
                     <tr><td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">  
                         <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                                                   
                            <tr>
                                <td nowrap="nowrap" style="width:200px">
                                    <asp:Label ID="lblSystemicHypertension_402" runat="server" Text="Systemic Hypertension"
                                        Font-Bold="True" meta:resourcekey="lblSystemicHypertension_402Resource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap">
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblShNill" runat="server" Text=" Nil" 
                                                    meta:resourcekey="lblShNillResource1"></asp:Label>
                                                <asp:Label ID="lblDurationShAI_1" runat="server" Text="Duration :-" 
                                                    Visible="False" meta:resourcekey="lblDurationShAI_1Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationShAVI_1" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDurationShAVI_1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblTreatmentShAI_2" runat="server" Text="Treatment :-" 
                                                    Visible="False" meta:resourcekey="lblTreatmentShAI_2Resource1"></asp:Label>
                                                <asp:Label ID="lblBetaBlockersShAVI_4" runat="server" Visible="False" 
                                                    meta:resourcekey="lblBetaBlockersShAVI_4Resource1"></asp:Label>
                                                <asp:Label ID="lblCCBShAVI_5" runat="server" Visible="False" 
                                                    meta:resourcekey="lblCCBShAVI_5Resource1"></asp:Label>
                                                <asp:Label ID="lblACEIARBShAVI_6" runat="server" Visible="False" 
                                                    meta:resourcekey="lblACEIARBShAVI_6Resource1"></asp:Label>
                                                <asp:Label ID="lblACEIARBdiureticShAVI_7" runat="server" Visible="False" 
                                                    meta:resourcekey="lblACEIARBdiureticShAVI_7Resource1"></asp:Label>
                                                <asp:Label ID="lblAlphaBlockersShAVI_8" runat="server" Visible="False" 
                                                    meta:resourcekey="lblAlphaBlockersShAVI_8Resource1"></asp:Label>
                                                <asp:Label ID="lblOthersShAVI_9" runat="server" Visible="False" 
                                                    meta:resourcekey="lblOthersShAVI_9Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblHeartDisease_332" runat="server" Text="Heart Disease " 
                                        Font-Bold="True" meta:resourcekey="lblHeartDisease_332Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblHDNil" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblHDNilResource1"></asp:Label>
                                                <asp:Label ID="lblDiseaseTypeHDAI_3" runat="server" Text="Disease Type :-" 
                                                    Visible="False" meta:resourcekey="lblDiseaseTypeHDAI_3Resource1"></asp:Label>
                                                <asp:Label ID="lblDiseaseTypeHDAVI_3" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDiseaseTypeHDAVI_3Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDiseaseHDAI_4" runat="server" Text="Disease :-" 
                                                    Visible="False" meta:resourcekey="lblDiseaseHDAI_4Resource1"></asp:Label>
                                                <asp:Label ID="lblDiseaseHDAVI_4" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDiseaseHDAVI_4Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblDiabetesMellitus_389" runat="server" Text="Diabetes Mellitus"
                                        Font-Bold="True" meta:resourcekey="lblDiabetesMellitus_389Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblDMNil" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblDMNilResource1"></asp:Label>
                                                <asp:Label ID="lblDurationDMAI_5" runat="server" Text="Duration :-" 
                                                    Visible="False" meta:resourcekey="lblDurationDMAI_5Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationDMAVI_5" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDurationDMAVI_5Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTypeDHAI_6" runat="server" Text="Type :-" Visible="False" 
                                                    meta:resourcekey="lblTypeDHAI_6Resource1"></asp:Label>
                                                <asp:Label ID="lblTypeDHAVI_6" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTypeDHAVI_6Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTreatmentDHAI_7" runat="server" Text="Treatment  :-" 
                                                    Visible="False" meta:resourcekey="lblTreatmentDHAI_7Resource1"></asp:Label>
                                                <asp:Label ID="lblTreatmentDHAVI_7" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTreatmentDHAVI_7Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblStroke__438" runat="server" Text="Stroke " Font-Bold="True" 
                                        meta:resourcekey="lblStroke__438Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblS_438" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblS_438Resource1"></asp:Label>
                                                <asp:Label ID="lblDateSAI_8" runat="server" Text="Date :-" Visible="False" 
                                                    meta:resourcekey="lblDateSAI_8Resource1"></asp:Label>
                                                <asp:Label ID="lblDateSAVI_8" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDateSAVI_8Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRecoverySAI_9" runat="server" Text="Recovery :-" 
                                                    Visible="False" meta:resourcekey="lblRecoverySAI_9Resource1"></asp:Label>
                                                <asp:Label ID="lblRecoverySAVI_9" runat="server" Visible="False" 
                                                    meta:resourcekey="lblRecoverySAVI_9Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTypeOfCVASAI_10" runat="server" Text="TypeOfCVA  :-" 
                                                    Visible="False" meta:resourcekey="lblTypeOfCVASAI_10Resource1"></asp:Label>
                                                <asp:Label ID="lblTypeOfCVASAVI_10" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTypeOfCVASAVI_10Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAreaLobeaffectedSAI_11" runat="server" Text="Area/Lobe affected  :-"
                                                    Visible="False" meta:resourcekey="lblAreaLobeaffectedSAI_11Resource1"></asp:Label>
                                                <asp:Label ID="lblAreaLobeaffectedSAVI_11" runat="server" Visible="False" 
                                                    meta:resourcekey="lblAreaLobeaffectedSAVI_11Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblDyslipidemia_409" runat="server" Text="Dyslipidemia  " 
                                        Font-Bold="True" meta:resourcekey="lblDyslipidemia_409Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblNil_409" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblNil_409Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationDLAI_12" runat="server" Text="Duration :-" 
                                                    Visible="False" meta:resourcekey="lblDurationDLAI_12Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationDLAVI_12" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDurationDLAVI_12Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblCancer_372" runat="server" Text="Cancer " Font-Bold="True" 
                                        meta:resourcekey="lblCancer_372Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblnil_372" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblnil_372Resource1"></asp:Label>
                                                <asp:Label ID="lblSOCCAI_13" runat="server" Text="Type Of Cancer  :-" 
                                                    Visible="False" meta:resourcekey="lblSOCCAI_13Resource1"></asp:Label>
                                                <asp:Label ID="lblSOCCAVI_13" runat="server" 
                                                    meta:resourcekey="lblSOCCAVI_13Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSOCCAI_14" runat="server" Text="Stage Of Cancer  :-" 
                                                    Visible="False" meta:resourcekey="lblSOCCAI_14Resource1"></asp:Label>
                                                <asp:Label ID="lblSOCCAVI_14" runat="server" 
                                                    meta:resourcekey="lblSOCCAVI_14Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSOCCAI_15" runat="server" Text="Treatment   :-" 
                                                    Visible="False" meta:resourcekey="lblSOCCAI_15Resource1"></asp:Label>
                                                <asp:Label ID="lblSOCCAVI_15" runat="server" 
                                                    meta:resourcekey="lblSOCCAVI_15Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblAsthma_246" runat="server" Text="Asthma  " Font-Bold="True" 
                                        meta:resourcekey="lblAsthma_246Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblNil_246" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblNil_246Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationAAI_16" runat="server" Text="Duration  :-" 
                                                    Visible="False" meta:resourcekey="lblDurationAAI_16Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationAAVI_16" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDurationAAVI_16Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTreatmentAAI_17" runat="server" Text="Treatment  :-" 
                                                    Visible="False" meta:resourcekey="lblTreatmentAAI_17Resource1"></asp:Label>
                                                <asp:Label ID="lblTreatmentAAVI_17" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTreatmentAAVI_17Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblExacerbationsAAI_18" runat="server" Text="Exacerbations   :-" 
                                                    Visible="False" meta:resourcekey="lblExacerbationsAAI_18Resource1"></asp:Label>
                                                <asp:Label ID="lblExacerbationsAAVI_18" runat="server" Visible="False" 
                                                    meta:resourcekey="lblExacerbationsAAVI_18Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblThalassemiaTrait_536" runat="server" Text="Thalassemia Trait  "
                                        Font-Bold="True" meta:resourcekey="lblThalassemiaTrait_536Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblNil_536" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblNil_536Resource1"></asp:Label>
                                                <asp:Label ID="lblTraitTTAI_19" runat="server" Text="Trait  :-" Visible="False" 
                                                    meta:resourcekey="lblTraitTTAI_19Resource1"></asp:Label>
                                                <asp:Label ID="lblTraitAVI_19" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTraitAVI_19Resource1"></asp:Label>
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
                            <tr>
                                <td>
                                    <asp:Label ID="lblHepatitisBcarrier_537" runat="server" Text="Hepatitis B Carrier  "
                                        Font-Bold="True" meta:resourcekey="lblHepatitisBcarrier_537Resource1"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblNil_537" runat="server" Text="Nil" 
                                                    meta:resourcekey="lblNil_537Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationHBCAI_20" runat="server" Text="Duration  :-" 
                                                    Visible="False" meta:resourcekey="lblDurationHBCAI_20Resource1"></asp:Label>
                                                <asp:Label ID="lblDurationHBCAVI_20" runat="server" Visible="False" 
                                                    meta:resourcekey="lblDurationHBCAVI_20Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp; &nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTreatmentHBCAI_21" runat="server" Text="Treatment  :-" 
                                                    Visible="False" meta:resourcekey="lblTreatmentHBCAI_21Resource1"></asp:Label>
                                                <asp:Label ID="lblTreatmentHBCAVI_21" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTreatmentHBCAVI_21Resource1"></asp:Label>
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
                        </table>
                         <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap" style="width:200px">
                                    <asp:Label ID="lblSurgery" runat="server" Text="Surgical History   " 
                                        Font-Bold="True" meta:resourcekey="lblSurgeryResource1"></asp:Label>
                                    
                                </td>
                                <td>
                                <asp:Label ID="lblSurgeryNil" runat="server" Text="Nil" 
                                        meta:resourcekey="lblSurgeryNilResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="90%" cellpadding="0" cellspacing="0" border="0">
                                        <asp:GridView ID="grdSurgery" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                            ForeColor="#333333" CssClass="mytable1" 
                                            meta:resourcekey="grdSurgeryResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Surgery Name" ItemStyle-Width="5%" 
                                                    meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSurgeryName" runat="server" Text='<%# Bind("SurgeryName") %>' 
                                                            meta:resourcekey="lblSurgeryNameResource1"></asp:Label>
                                                    </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date" ItemStyle-Width="5%" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTreatmentPlanDate" runat="server" 
                                                            Text='<%# Bind("TreatmentPlanDate") %>' 
                                                            meta:resourcekey="lblTreatmentPlanDateResource1"></asp:Label>
                                                    </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Hospital/Centre" ItemStyle-Width="5%" 
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblHospitalName" runat="server" 
                                                            Text='<%# Bind("HospitalName") %>' meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                                    </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    
                         </td>
                        </tr>
                        </table>
                        
                           
                        <br />
                        <table width="100%">
            <tr>
                <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                    align="center">
                    <asp:Label ID="Label4" runat="server" Text="SOCIAL HISTORY" 
                        meta:resourcekey="Label4Resource1"></asp:Label>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
            <tr>
                <td>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" style="width:200px" >
                                <asp:Label ID="lblTobaccoSmoking_476" Font-Bold="True" runat="server" 
                                    Text="Tobacco Smoking  " meta:resourcekey="lblTobaccoSmoking_476Resource1"></asp:Label>
                              
                            </td>
                            <td>
                                <table style="width: 100%;">
                                    <tr>
                                        <td>   
                                             <asp:Label ID="lblTSNil" runat="server" Text="Nil" 
                                                 meta:resourcekey="lblTSNilResource1"></asp:Label>                                    
                                            <asp:Label ID="lblTypeTS_1" runat="server" Visible="False" Text="Type :- " 
                                                 meta:resourcekey="lblTypeTS_1Resource1"></asp:Label>
                                            <asp:Label ID="lblCCB" runat="server" Visible="False" 
                                                 meta:resourcekey="lblCCBResource1"></asp:Label>
                                            &nbsp;<asp:Label ID="lblDurationTSAV_2" Visible="False" runat="server" 
                                                 Text="Duration :- " meta:resourcekey="lblDurationTSAV_2Resource1"></asp:Label>
                                            <asp:Label ID="lblDurationTSAVI_5" Visible="False" runat="server" 
                                                 meta:resourcekey="lblDurationTSAVI_5Resource1"></asp:Label>
                                            &nbsp;<asp:Label ID="lblPacksTSAV_3" Visible="False" runat="server" 
                                                 Text="Packs :- " meta:resourcekey="lblPacksTSAV_3Resource1"></asp:Label>
                                            <asp:Label ID="lblPacksTS" Visible="False" runat="server" 
                                                 meta:resourcekey="lblPacksTSResource1"></asp:Label>
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
                        <tr>
                            <td nowrap="nowrap" style="width:200px">
                                <asp:Label ID="lblAlcoholConsumption_369" Font-Bold="True" runat="server" 
                                    Text="Alcohol Consumption " 
                                    meta:resourcekey="lblAlcoholConsumption_369Resource1"></asp:Label>
                          
                            </td>
                            <td>
                                <table style="width: 100%;">
                                    <tr>
                                        <td> 
                                           <asp:Label ID="lblACNil" runat="server" Text="Nil" 
                                                meta:resourcekey="lblACNilResource1"></asp:Label>
                                            <asp:Label ID="lblTypeAC_4" runat="server" Visible="False" Text="Type :- " 
                                                meta:resourcekey="lblTypeAC_4Resource1"></asp:Label>
                                            <asp:Label ID="lblTypeAC" runat="server" Visible="False" 
                                                meta:resourcekey="lblTypeACResource1"></asp:Label>
                                            &nbsp;<asp:Label ID="lblDurationACAV_5" Visible="False" runat="server" 
                                                Text="Duration :- " meta:resourcekey="lblDurationACAV_5Resource1"></asp:Label>
                                            <asp:Label ID="lblDurationACAVI_13" Visible="False" runat="server" 
                                                meta:resourcekey="lblDurationACAVI_13Resource1"></asp:Label>
                                            &nbsp;<asp:Label ID="lblQTYAC_6" Visible="False" runat="server" 
                                                Text="Quantity :- " meta:resourcekey="lblQTYAC_6Resource1"></asp:Label>
                                            <asp:Label ID="lblACQty" Visible="False" runat="server" 
                                                meta:resourcekey="lblACQtyResource1"></asp:Label>
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
                        <tr>
                            <td nowrap="nowrap" style="width:200px">
                                <asp:Label ID="lblPhysActivity_1059" runat="server" Font-Bold="True" 
                                    Text="Physicial Activity " meta:resourcekey="lblPhysActivity_1059Resource1"></asp:Label>
                          
                            </td>
                            <td>
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                              <asp:Label ID="lblPhyActNil" runat="server" Text="Nil" 
                                                  meta:resourcekey="lblPhyActNilResource1"></asp:Label>
                                            <asp:Label ID="lblPhyExHead" runat="server" Text="Physicial Exercise :- " 
                                                  Visible="False" meta:resourcekey="lblPhyExHeadResource1"></asp:Label><asp:Label
                                                ID="lblPhyExcersice_7" runat="server" Visible="False" 
                                                  meta:resourcekey="lblPhyExcersice_7Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="trPhyExeOccasional" runat="server">
                                            <asp:Label ID="lblAerobic_8" runat="server" Visible="False" 
                                                Text="Aerobic    :-" meta:resourcekey="lblAerobic_8Resource1"></asp:Label>&nbsp;<asp:Label
                                                ID="lblAerobicText" runat="server" Visible="False" 
                                                meta:resourcekey="lblAerobicTextResource1"></asp:Label>
                                            &nbsp;
                                            <asp:Label ID="lblAnAerobic_9" runat="server" Visible="False" 
                                                Text="Anaerobic  :-" meta:resourcekey="lblAnAerobic_9Resource1"></asp:Label>&nbsp;<asp:Label
                                                ID="lblAnAerobicText" runat="server" Visible="False" 
                                                meta:resourcekey="lblAnAerobicTextResource1"></asp:Label>
                                            &nbsp;
                                            <asp:Label ID="lblPhyExeDuration_10" runat="server" Visible="False" 
                                                Text="Duration     :-" meta:resourcekey="lblPhyExeDuration_10Resource1"></asp:Label>&nbsp;<asp:Label
                                                ID="lblPhyExeDuration" runat="server" Visible="False" 
                                                meta:resourcekey="lblPhyExeDurationResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                    </table>
                </td>
            </tr>
        </table>
        
          <table width="100%">
            <tr>
                <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                    align="center">
                    <asp:Label ID="Label5" runat="server" Text="ALLERGIC HISTORY" 
                        meta:resourcekey="Label5Resource1"></asp:Label>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
                     <tr><td>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:Label ID="lblAllergicHis" runat="server" Font-Bold="True" Text="Allergic History"
                                    Visible="False" meta:resourcekey="lblAllergicHisResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1">
                                <asp:Label ID="lblDrugAllergy" runat="server" Visible="False" 
                                    Text="Drug Type :- " meta:resourcekey="lblDrugAllergyResource1"></asp:Label>
                                <asp:Label ID="lblDrugAllergyValue" runat="server" Visible="False" 
                                    meta:resourcekey="lblDrugAllergyValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblFoodStuff" runat="server" Visible="False" 
                                    Text="Food Stuff :- " meta:resourcekey="lblFoodStuffResource1"></asp:Label>
                                <asp:Label ID="lblFoodStuffValue" runat="server" Visible="False" 
                                    meta:resourcekey="lblFoodStuffValueResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" style="width:200px">
                    <asp:Label ID="lblDrugHistory_1063" runat="server" Font-Bold="True" 
                        Text="Drug History " meta:resourcekey="lblDrugHistory_1063Resource1"></asp:Label>
                    
                </td>
                <td>
                <asp:Label ID="lblDHNil" runat="server" Text="Nil" 
                        meta:resourcekey="lblDHNilResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:GridView ID="grdPrescription" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                    ForeColor="#333333" CssClass="mytable1" 
                                    meta:resourcekey="grdPrescriptionResource1">
                                    <HeaderStyle CssClass="dataheader1" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Drug Name" ItemStyle-Width="25%" 
                                            meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>' 
                                                    meta:resourcekey="lblDrugNameResource1"></asp:Label>
                                                -
                                                <asp:Label ID="l1" runat="server" Text="(" meta:resourcekey="l1Resource2"></asp:Label>
                                                <asp:Label ID="lblDrugFormulation" runat="server" 
                                                    Text='<%# Bind("DrugFormulation") %>' 
                                                    meta:resourcekey="lblDrugFormulationResource1"></asp:Label>
                                                <asp:Label ID="Label1" runat="server" Text=")" 
                                                    meta:resourcekey="Label1Resource2"></asp:Label>
                                                -<asp:Label ID="Label3" runat="server" Text="(" 
                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                                <asp:Label ID="lblDose" runat="server" Text='<%# Bind("Dose") %>' 
                                                    meta:resourcekey="lblDoseResource1"></asp:Label>
                                                <asp:Label ID="Label2" runat="server" Text=")" 
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="25%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Drug Frequency" ItemStyle-Width="5%" 
                                            meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDrugFrequency" runat="server" 
                                                    Text='<%# Bind("DrugFrequency") %>' 
                                                    meta:resourcekey="lblDrugFrequencyResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Duration" ItemStyle-Width="15%" 
                                            meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDuration" runat="server" Text='<%# Bind("days") %>' 
                                                    meta:resourcekey="lblDurationResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="15%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Instruction" ItemStyle-Width="25%" 
                                            meta:resourcekey="TemplateFieldResource7">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInstruction" runat="server" Text='<%# Bind("Instruction") %>' 
                                                    meta:resourcekey="lblInstructionResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="25%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" style="width:200px">
                    <asp:Label ID="LblVaccinationHistory_1064" Font-Bold="True" runat="server" 
                        Text="Vaccination History " 
                        meta:resourcekey="LblVaccinationHistory_1064Resource1"></asp:Label>
                </td>
                <td>
                 <asp:Label ID="LblVHNil" runat="server" Text="Nil" 
                        meta:resourcekey="LblVHNilResource1"></asp:Label>

                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:GridView ID="grdPPVH" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                    ForeColor="#333333" CssClass="mytable1" 
                                    meta:resourcekey="grdPPVHResource1">
                                    <HeaderStyle CssClass="dataheader1" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Vaccination Name" ItemStyle-Width="5%" 
                                            meta:resourcekey="TemplateFieldResource8">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVaccinationName" runat="server" 
                                                    Text='<%# Bind("VaccinationName") %>' 
                                                    meta:resourcekey="lblVaccinationNameResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vaccination Dose" ItemStyle-Width="5%" 
                                            meta:resourcekey="TemplateFieldResource9">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVaccinationDose" runat="server" 
                                                    Text='<%# Bind("VaccinationDose") %>' 
                                                    meta:resourcekey="lblVaccinationDoseResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vaccination Time" ItemStyle-Width="5%" 
                                            meta:resourcekey="TemplateFieldResource10">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMonthOfVaccination" runat="server" 
                                                    Text='<%# Bind("MonthOfVaccination") %>' 
                                                    meta:resourcekey="lblMonthOfVaccinationResource1"></asp:Label>
                                                <asp:Label ID="txtbar" runat="server" Text="/" 
                                                    meta:resourcekey="txtbarResource1"></asp:Label>
                                                <asp:Label ID="lblYearOfVaccination" runat="server" 
                                                    Text='<%# Bind("YearOfVaccination") %>' 
                                                    meta:resourcekey="lblYearOfVaccinationResource1"></asp:Label>
                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
        </tr>
        </table>
           
           
           <table width="100%" runat="server" id="tblGynacHisH">
           <tr>
                <td>
                   &nbsp;
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                    align="center">
                    <asp:Label ID="Label6" runat="server" Text="OBSTRETIC/GYNAECOLOGICAL HISTORY" 
                        meta:resourcekey="Label6Resource1"></asp:Label>
                </td>
            </tr>
        </table>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl"
                            runat="server" id="tblGynacHisC">
                            <tr>
                                <td>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>
                                        <table>
                                        <tr>
                                        <td>
                                        <table>
                                        <tr>
                                        <td nowrap="nowrap" style="width:200px">
                                                <asp:Label ID="LblGynaecologicalHitory_1065" Font-Bold="True" runat="server" 
                                                    Text="Gynaecological Hitory " 
                                                    meta:resourcekey="LblGynaecologicalHitory_1065Resource1"></asp:Label>
                                               
                                            </td>
                                            <td>
                                             <asp:Label ID="LblGHNil" runat="server" Text="Nil" 
                                                    meta:resourcekey="LblGHNilResource1"></asp:Label>
                                            </td>
                                            </tr>
                                        </table>
                                        </td>
                                         
                                        </tr>
                                        </table>
                                        </td>
                                           
                                        </tr>                                        
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 125px;">
                                                            <asp:Label ID="lblLMPDate_13" Font-Bold="True" Visible="False" runat="server" CssClass="defaultfontcolor"
                                                                Text="LMP Date" meta:resourcekey="lblLMPDate_13Resource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 75px;">
                                                            <asp:Label ID="lblLMPDate_38" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblLMPDate_38Resource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 160px;">
                                                            <asp:Label ID="lblMenstrualCycle_14" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Menstrual Cycle" 
                                                                meta:resourcekey="lblMenstrualCycle_14Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblMenstrualCyc" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblMenstrualCycResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblCycleLength_15" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Cycle Length(approx)" 
                                                                meta:resourcekey="lblCycleLength_15Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCycleLength_45" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblCycleLength_45Resource1"></asp:Label>
                                                            <asp:Label ID="lblCyclelengthDays" Visible="False" runat="server" CssClass="defaultfontcolor"
                                                                Text="days" meta:resourcekey="lblCyclelengthDaysResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastPapSmear" Font-Bold="True" Visible="False" runat="server" CssClass="defaultfontcolor"
                                                                Text="Last Pap Smear" meta:resourcekey="lblLastPapSmearResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastPapSmear_46" Visible="False" CssClass="defaultfontcolor" 
                                                                runat="server" meta:resourcekey="lblLastPapSmear_46Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblAgeofMenarchy_18" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Age of Menarchy" 
                                                                meta:resourcekey="lblAgeofMenarchy_18Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAgeofMenarchy_47" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblAgeofMenarchy_47Resource1"></asp:Label>
                                                            <asp:Label ID="lblAgeofMenarchyYears_47" Visible="False" runat="server" CssClass="defaultfontcolor"
                                                                Text="Years" meta:resourcekey="lblAgeofMenarchyYears_47Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastPapSmearResult_19" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Result" 
                                                                meta:resourcekey="lblLastPapSmearResult_19Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastPapSmearResult" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblLastPapSmearResultResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblLastMamogram_20" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Last Mammogram" 
                                                                meta:resourcekey="lblLastMamogram_20Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastMamogram" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblLastMamogramResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblContraception_17" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Contraception" 
                                                                meta:resourcekey="lblContraception_17Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblContraception" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblContraceptionResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblLastMamogramResult_21" Font-Bold="True" Visible="False" runat="server"
                                                                CssClass="defaultfontcolor" Text="Result" 
                                                                meta:resourcekey="lblLastMamogramResult_21Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLastMamogramResult" Visible="False" runat="server" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblLastMamogramResultResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
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
                                        <tr>
                                        <td>
                                        <table>
                                        <tr>
                                        <td nowrap="nowrap" style="width:200px">
                                                <asp:Label ID="LblHormoneReplacementTheraphy_1066" Font-Bold="True" runat="server"
                                                    Text="Hormone Replacement Therapy" 
                                                    meta:resourcekey="LblHormoneReplacementTheraphy_1066Resource1"></asp:Label>
                                              
                                            </td>
                                            <td>
                                              <asp:Label ID="LblHRTil0" runat="server" Text="Nil" 
                                                    meta:resourcekey="LblHRTil0Resource1"></asp:Label>
                                            </td>
                                        </tr>
                                        </table>
                                        </td>
                                            
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblTypeofHRT_22" runat="server" Visible="False"
                                                    Text="Type of HRT   :- " meta:resourcekey="lblTypeofHRT_22Resource1"></asp:Label>
                                                <asp:Label ID="lblTypeofHRT" runat="server" Visible="False" 
                                                    meta:resourcekey="lblTypeofHRTResource1"></asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblHRTDelivery_23" Visible="False" runat="server"
                                                    Text="HRT Delivery :- " meta:resourcekey="lblHRTDelivery_23Resource1"></asp:Label>
                                                <asp:Label ID="lblHRTDelivery" runat="server" 
                                                    meta:resourcekey="lblHRTDeliveryResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblGravida" Font-Bold="True" Visible="False" Text="Gravida : " 
                                                    runat="server" meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                <asp:Label ID="lblG" Visible="False" runat="server" 
                                                    meta:resourcekey="lblGResource1"></asp:Label>
                                                <asp:Label ID="lblPara" Font-Bold="True" Text="Para : " Visible="False" 
                                                    runat="server" meta:resourcekey="lblParaResource1"></asp:Label>
                                                <asp:Label ID="lblP" Visible="False" runat="server" 
                                                    meta:resourcekey="lblPResource1"></asp:Label>
                                                <asp:Label ID="lblLive" Font-Bold="True" Text="Live : " Visible="False" 
                                                    runat="server" meta:resourcekey="lblLiveResource1"></asp:Label>
                                                <asp:Label ID="lblL" Visible="False" runat="server" 
                                                    meta:resourcekey="lblLResource1"></asp:Label>
                                                <asp:Label ID="lblAbortus" Font-Bold="True" Text="Abortus : " Visible="False" 
                                                    runat="server" meta:resourcekey="lblAbortusResource1"></asp:Label>
                                                <asp:Label ID="lblA" Visible="False" runat="server" 
                                                    meta:resourcekey="lblAResource1"></asp:Label>
                                                <asp:Label ID="lblGPLAOthers" Font-Bold="True" Text="Others : " Visible="False" 
                                                    runat="server" meta:resourcekey="lblGPLAOthersResource1"></asp:Label>
                                                <asp:Label ID="lblGPLAO" Visible="False" runat="server" 
                                                    meta:resourcekey="lblGPLAOResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>
                                        <table>
                                        <tr>
                                        <td nowrap="nowrap" style="width:200px">
                                                <asp:Label ID="lblOBSTRETICHISTORY_1067" runat="server" Font-Bold="True" 
                                                    Text="Obstretic History  " meta:resourcekey="lblOBSTRETICHISTORY_1067Resource1"></asp:Label>
                                               
                                            </td>
                                        <td>
                                         <asp:Label ID="lblObsHisNil" runat="server" Text="Nil" 
                                                meta:resourcekey="lblObsHisNilResource1"></asp:Label>
                                        </td>
                                        
                                        </tr>
                                        </table>
                                        </td>
                                            
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdObsHistory" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                    ForeColor="#333333" CssClass="mytable1" 
                                                    meta:resourcekey="grdObsHistoryResource1">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Age / Sex" ItemStyle-Width="5%" 
                                                            meta:resourcekey="TemplateFieldResource11">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' 
                                                                    meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                <asp:Label ID="lblBar1" runat="server" Text="/" 
                                                                    meta:resourcekey="lblBar1Resource1"></asp:Label>
                                                                <asp:Label ID="lblSexOfChild" runat="server" Text='<%# Bind("SexOfChild") %>' 
                                                                    meta:resourcekey="lblSexOfChildResource1"></asp:Label>
                                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="BirthWeight" ItemStyle-Width="5%" 
                                                            meta:resourcekey="TemplateFieldResource12">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBirthWeight" runat="server" Text='<%# Bind("BirthWeight") %>' 
                                                                    meta:resourcekey="lblBirthWeightResource1"></asp:Label>
                                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GrowthNormal" Visible="false" 
                                                            ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource13">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGrowthNormal" runat="server" 
                                                                    Text='<%# Bind("GrowthNormal") %>' meta:resourcekey="lblGrowthNormalResource1"></asp:Label>
                                                            </ItemTemplate>

<ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ModeOfDelivery" ItemStyle-Width="20%" 
                                                            meta:resourcekey="TemplateFieldResource14">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblModeOfDelivery" runat="server" 
                                                                    Text='<%# Bind("ModeOfDelivery") %>' 
                                                                    meta:resourcekey="lblModeOfDeliveryResource1"></asp:Label>
                                                            </ItemTemplate>

<ItemStyle Width="20%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="BirthMaturity" ItemStyle-Width="20%" 
                                                            meta:resourcekey="TemplateFieldResource15">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBirthMaturity" runat="server" 
                                                                    Text='<%# Bind("BirthMaturity") %>' 
                                                                    meta:resourcekey="lblBirthMaturityResource1"></asp:Label>
                                                            </ItemTemplate>

<ItemStyle Width="20%"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
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
                      <table style="width: 75%;">
                        <tr>
                            <td>
                                <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                    meta:resourcekey="btnPrintResource1" />
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" onclick="btnEdit_Click" 
                                    meta:resourcekey="btnEditResource1"  />
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
