<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ANCCaseSheet.ascx.cs" Inherits="ANC_ANCCaseSheet" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    .style4
    {
        width: 50%;
    }
    .style5
    {
        width: 50%;
        height: 5px;
    }
    .style6
    {
        height: 5px;
    }
</style>
<table width="100%" enableviewstate="false">
    <tr>
        <td >
            <div id="divANCCS" runat="server">
            <table width="100%">
                <tr>
                    <td colspan="2">
                        
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <asp:Label ID="lblDocterName" runat="server" 
                            meta:resourcekey="lblDocterNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table width="75%">
                            <tr align="left">
                                <td>
                                    <div id="divVHeader" runat="server" class="ancCSredColorBold"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_VitalDetails" Text="Vital Details" runat="server" 
                                            meta:resourcekey="Rs_VitalDetailsResource1"></asp:Label></span></div></td>
                                <td>
                                    <div id="div1" runat="server" class="ancCSredColorBold"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_ClinicalDetails" Text="Clinical Details" runat="server" 
                                            meta:resourcekey="Rs_ClinicalDetailsResource1"></asp:Label></span></div></td>
                                <td>
                                    <span id="bgpPMH" runat="server" style="text-decoration: underline;" class="ancCSredColorBold">
                                    <asp:Label ID="Rs_PastMedicalHistory" Text="Past Medical History" 
                                        runat="server" meta:resourcekey="Rs_PastMedicalHistoryResource1"></asp:Label></span></td>
                            </tr>
                            <tr>
                                <td style="text-align: left" rowspan="4">
                                    <%--RR--%><%-----%><table width="100%">
                                        <tr id="trPulse" runat="server">
                                            <td>
                                    
                                    <span class='ancCSredColorBold'><asp:Label ID="Rs_Pulse" Text="Pulse" runat="server" 
                                                    meta:resourcekey="Rs_PulseResource1"></asp:Label></span>
                                            </td>
                                            <td>
                                    -
                                            </td>
                                            <td>
                                    <asp:Label ID="lblPulse" CssClass="ancCSredColor" runat="server" 
                                                    meta:resourcekey="lblPulseResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trBP" runat="server">
                                            <td>
                                    
                                    <span class='ancCSredColorBold'><asp:Label ID="Rs_BP" Text="BP" runat="server" 
                                                    meta:resourcekey="Rs_BPResource1"></asp:Label></span>
                                            </td>
                                            <td>
                                    -
                                            </td>
                                            <td>
                                    <asp:Label ID="lblBP" CssClass="ancCSredColor" runat="server" 
                                                    meta:resourcekey="lblBPResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trTemp" runat="server">
                                            <td>
                                    
                                    <span class='ancCSredColorBold'><asp:Label ID="Rs_Temp" Text="Temp" runat="server" 
                                                    meta:resourcekey="Rs_TempResource1"></asp:Label>
                                    </span>
                                            </td>
                                            <td>
                                    -
                                            </td>
                                            <td>
                                    <asp:Label ID="lblTemp" CssClass="ancCSredColor" runat="server" 
                                                    meta:resourcekey="lblTempResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trWeight" runat="server">
                                            <td>
                                    
                                    <span class='ancCSredColorBold'><asp:Label ID="Rs_Weight" Text="Weight" runat="server" 
                                                    meta:resourcekey="Rs_WeightResource1"></asp:Label></span>
                                            </td>
                                            <td>
                                    -
                                            </td>
                                            <td>
                                            <asp:Label ID="lblWeight" CssClass="ancCSredColor" runat="server" 
                                                    meta:resourcekey="lblWeightResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                <asp:Label ID="lblRR" CssClass="ancCSredColor" runat="server"></asp:Label>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </td>
                                <td style="text-align: left">
                                    <b class="ancCSredColorBold"><asp:Label ID="Rs_G" Text="G" runat="server" 
                                        meta:resourcekey="Rs_GResource1"></asp:Label></b>-<sub>
                                    <asp:Label ID="lblG" CssClass="ancCSredColor" runat="server" 
                                        meta:resourcekey="lblGResource1"></asp:Label></sub>
                                    , <b class="ancCSredColorBold"><asp:Label ID="Rs_P" Text="P" runat="server" 
                                        meta:resourcekey="Rs_PResource1"></asp:Label></b>-<sub>
                                    <asp:Label ID="lblP" CssClass="ancCSredColor" runat="server" 
                                        meta:resourcekey="lblPResource1"></asp:Label></sub>
                                    , <b class="ancCSredColorBold"><asp:Label ID="Rs_L" Text="L" runat="server" 
                                        meta:resourcekey="Rs_LResource1"></asp:Label></b>-<sub>
                                    <asp:Label ID="lblL" CssClass="ancCSredColor" runat="server" 
                                        meta:resourcekey="lblLResource1"></asp:Label></sub>
                                    , <b class="ancCSredColorBold"><asp:Label ID="Rs_A" Text="A"  runat="server" 
                                        meta:resourcekey="Rs_AResource1"></asp:Label></b>-<sub>
                                    <asp:Label ID="lblA" CssClass="ancCSredColor" runat="server" 
                                        meta:resourcekey="lblAResource1"></asp:Label></sub>
                                </td>
                                <td rowspan="4" valign="top">
                                    <asp:Label ID="lblBGP" runat="server" meta:resourcekey="lblBGPResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <div id="divLMP" runat="server">
                                    <span class='ancCSredColorBold'><asp:Label ID="Rs_LMP" Text="LMP -" runat="server" 
                                            meta:resourcekey="Rs_LMPResource1"></asp:Label> </span>
                                    <asp:Label ID="lblLMP" CssClass="ancCSredColor" runat="server" 
                                            meta:resourcekey="lblLMPResource1"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <div id="divEDD" runat="server">
                                    <span class='ancCSredColorBold'><asp:Label ID= "Rs_EDD" Text="EDD -" runat="server" 
                                            meta:resourcekey="Rs_EDDResource1"></asp:Label> </span>
                                    <asp:Label ID="lblEDD" CssClass="ancCSredColor" runat="server" 
                                            meta:resourcekey="lblEDDResource1"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:Label ID="lblPrimiBOH" runat="server" CssClass="ancCSredColor" 
                                        meta:resourcekey="lblPrimiBOHResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left" colspan="2">
                        <asp:Label ID="lblComplaintDesc" runat="server" 
                            meta:resourcekey="lblComplaintDescResource1"></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px;">
                    <td class="style4;">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="text-align: left" colspan="2">
                        <div class="ancCSredColorBold"><span style="text-decoration: underline;">
                            <asp:Label ID="Rs_Treatment" Text="Treatment :- " runat="server" 
                                meta:resourcekey="Rs_TreatmentResource1"></asp:Label></span></div></td>
                </tr>
                <tr style="width: 100%">
                    <td colspan="2">
                        <asp:Label ID="lblPrescription" runat="server" 
                            meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="style5">
                        </td>
                    <td class="style6">
                        </td>
                </tr>
                <tr valign="top">
                    <td style="text-align: left" class="style4">
                        <div id="trInv" runat="server" style="border-style: none;">
                            <div class="ancCSredColorBold"><span style="text-decoration: underline;">
                                <asp:Label ID="Rs_InvestigationReport" Text="Investigation&#39;s Report :-" 
                                    runat="server" meta:resourcekey="Rs_InvestigationReportResource1"></asp:Label> </span></div>
                            <asp:Label ID="lblInvestigation" runat="server" 
                                meta:resourcekey="lblInvestigationResource1"></asp:Label>
                        </div>
                        <hr />
                        <div style="border-style: none;">
                            <div class="ancCSredColorBold"><span style="text-decoration: underline;">
                                <asp:Label ID="Rs_GeneralAdvice" Text="General Advice :-" runat="server" 
                                    meta:resourcekey="Rs_GeneralAdviceResource1"></asp:Label> </span></div>
                            <asp:Label ID="lblANCAdvice" runat="server" 
                                meta:resourcekey="lblANCAdviceResource1"></asp:Label>
                        </div>
                        <hr />
                        <div style="border-style: none;">
                                    <div class="ancCSredColorBold"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_NextReview" Text="Next Review (On/After) :-" runat="server" 
                                            meta:resourcekey="Rs_NextReviewResource1"></asp:Label></span> 
                                    <asp:Label ID="lblReviewDate" runat="server" 
                                            meta:resourcekey="lblReviewDateResource1"></asp:Label></div>
                                    
                                    <div class="ancCSredColorBold" id="trdusd" runat="server"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_PreviousUSD" Text="Previous USD :-" runat="server" 
                                            meta:resourcekey="Rs_PreviousUSDResource1"></asp:Label></span> 
                                    <asp:Label ID="lblDateofUSD" runat="server" Text="Label" 
                                            meta:resourcekey="lblDateofUSDResource1"></asp:Label></div>
                                    
                                    <div class="ancCSredColorBold" id="trAdmission" runat="server"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_Admission" Text="Admission :-" runat="server" 
                                            meta:resourcekey="Rs_AdmissionResource1"></asp:Label></span> 
                                    <asp:Label ID="lblAdmission" runat="server" 
                                            meta:resourcekey="lblAdmissionResource1"></asp:Label></div>
                                    
                                    <div class="ancCSredColorBold" id="trScan" runat="server"><span style="text-decoration: underline;">
                                        <asp:Label ID="Rs_Scan" Text="Scan:-" runat="server" 
                                            meta:resourcekey="Rs_ScanResource1"></asp:Label></span> 
                                    <asp:Label ID="lblScan" runat="server" meta:resourcekey="lblScanResource1"></asp:Label></div>
                        </div>
                    </td>
                    <td style="text-align: left">
                        <div id="trAlerts" runat="server" style="border-style: none;">
                            <div class="ancCSredColorBold"><span style="text-decoration: underline;">
                                <asp:Label ID="Rs_Alerts" Text="Alerts" runat="server" 
                                    meta:resourcekey="Rs_AlertsResource1"></asp:Label> </span>
                                <asp:Label ID="Rs_Info" Text="(Report to the hospital immediately in case of the following warning 
                                    signs)" runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label></div>
                            <asp:Label ID="lblANCAlerts" runat="server" 
                                meta:resourcekey="lblANCAlertsResource1"></asp:Label>
                        </div>
                        
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="style4">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                    <tr align="center">
        <td colspan="2">
            <asp:Label ID="lblautoGenerate" CssClass="ancCSredColor" Visible="False" 
                runat="server" 
                Text="Note: Since this is a Computer Generated CaseSheet, No Signature Required" 
                meta:resourcekey="lblautoGenerateResource1"></asp:Label>
        </td>
    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblMessage" runat="server" 
                meta:resourcekey="lblMessageResource1"></asp:Label>
        </td>
    </tr>

</table>
