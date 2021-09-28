<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmissionChkList.ascx.cs"
    Inherits="CommonControls_AdmissionChkList" %>
<style type="text/css">
    .fontSizes
    {
        font-size: 12px;
        font-family: Verdana, Arial;
    }
    .rowHeight
    {
        height: 30;
    }
</style>
<table width="700px" class="fontSizes" border="0" cellspacing="0" cellpadding="0"
    align="left">
    <tr>
        <td>
            <table width="700px" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" height="100">
                        <asp:Label ID="lblOrganizationName" runat="server" Style="font-weight: bold; font-size: 22px;"
                            meta:resourcekey="lblOrganizationNameResource1"></asp:Label>
                        <br />
                        <asp:Label ID="lblOrgAddress" runat="server" Style="font-weight: bold; font-size: 14px;"
                            meta:resourcekey="lblOrgAddressResource1"></asp:Label>
                        <br />
                        <div align="center" style="font-weight: bold; font-size: 16px" colspan="6">
                            <u>
                                <asp:Label ID="Rs_INPATIENTADMISSION" runat="server" Text="INPATIENT ADMISSION" meta:resourcekey="Rs_INPATIENTADMISSIONResource1"></asp:Label>
                                &amp;<asp:Label ID="Rs_DISCHARGEDATA" runat="server" Text="DISCHARGE DATA" meta:resourcekey="Rs_DISCHARGEDATAResource1"></asp:Label>
                            </u>
                        </div>
                    </td>
                </tr>
            </table>
            <table width="700px" border="1" class="fontSizes" cellspacing="0" cellpadding="0"
                align="left">
                <%--<tr>
                    <td align="left" nowrap="nowrap" style="font-weight: bold" colspan="6">
                        
                    </td>
                </tr>--%>
                <%--<tr>
                    <td colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr>
                    <td align="center" style="font-weight: bold; font-size: 16px" colspan="4" height="35">
                        <u>
                            <asp:Label ID="Rs_ADMISSIONSTATUS" runat="server" Text="ADMISSION STATUS" meta:resourcekey="Rs_ADMISSIONSTATUSResource1"></asp:Label></u>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_NameofthePatient" runat="server" Text="Name of the Patient" meta:resourcekey="Rs_NameofthePatientResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_AgeSex" runat="server" Text="Age / Sex" meta:resourcekey="Rs_AgeSexResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                        /
                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_PatientID" runat="server" Text="Patient ID" meta:resourcekey="Rs_PatientIDResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblPatientNumber" runat="server" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_IPNo" runat="server" Text="IP No" meta:resourcekey="Rs_IPNoResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblIPNo" runat="server" meta:resourcekey="lblIPNoResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_FatherHusbandGuardian" runat="server" Text="Father / Husband / Guardian"
                            meta:resourcekey="Rs_FatherHusbandGuardianResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblRelationName" runat="server" meta:resourcekey="lblRelationNameResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" height="65" style="font-weight: bold">
                        <asp:Label ID="Rs_PermanentAddress" runat="server" Text="Permanent Address" meta:resourcekey="Rs_PermanentAddressResource1"></asp:Label>
                    </td>
                    <td align="left" style="width: 100px;">
                        <asp:Label ID="lblAddress" runat="server" meta:resourcekey="lblAddressResource1"></asp:Label>
                    </td>
                    <td align="left" style="font-weight: bold;">
                        <asp:Label ID="Rs_TemporaryAddress" runat="server" Text="Temporary Address" meta:resourcekey="Rs_TemporaryAddressResource1"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblTempAdd" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_ContactNoMobile" runat="server" Text="Contact No (Mobile)" meta:resourcekey="Rs_ContactNoMobileResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblContactNo" runat="server" meta:resourcekey="lblContactNoResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_LandLineNo" runat="server" Text="Land Line No" meta:resourcekey="Rs_LandLineNoResource1"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblLLN" runat="server" meta:resourcekey="lblLLNResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_InCaseofEmergencyContact" runat="server" Text="In Case of Emergency Contact"
                            meta:resourcekey="Rs_InCaseofEmergencyContactResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblEC" runat="server" meta:resourcekey="lblECResource1"></asp:Label>
                        &nbsp;
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_Ward" runat="server" Text="Ward" meta:resourcekey="Rs_WardResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblWard" runat="server" meta:resourcekey="lblWardResource1"></asp:Label>&nbsp;
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_RoomNo" runat="server" Text="Room No" meta:resourcekey="Rs_RoomNoResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblRoomNo" runat="server" meta:resourcekey="lblRoomNoResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <label>
                            <asp:Label ID="Rs_ConsultantName" runat="server" Text="Consultant Name" meta:resourcekey="Rs_ConsultantNameResource1"></asp:Label></label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblRefPhysician" runat="server" meta:resourcekey="lblRefPhysicianResource1"></asp:Label>
                        &nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_AdmittingDoctor" runat="server" Text="Admitting Doctor" meta:resourcekey="Rs_AdmittingDoctorResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="1">
                        <asp:Label ID="lblMedicalDutyOfficer" runat="server" meta:resourcekey="lblMedicalDutyOfficerResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_ReferredDoctor" runat="server" Text="Referred Doctor" meta:resourcekey="Rs_ReferredDoctorResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblReferringDr" runat="server" meta:resourcekey="lblReferringDrResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_AdmissionDatetime" runat="server" Text="Admission Date & time"
                            meta:resourcekey="Rs_AdmissionDatetimeResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblDateTime" runat="server" meta:resourcekey="lblDateTimeResource1"></asp:Label>&nbsp;
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_DischargeDatetime" runat="server" Text="Discharge Date & time"
                            meta:resourcekey="Rs_DischargeDatetimeResource1"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" nowrap="nowrap">
                        <asp:Label ID="lblDischargeDateTime" runat="server" meta:resourcekey="lblDischargeDateTimeResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_MLC" runat="server" Text="MLC" meta:resourcekey="Rs_MLCResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblYes" Text="Yes" runat="server" meta:resourcekey="lblYesResource1"></asp:Label>
                        /
                        <asp:Label ID="lblNo" Text="No" runat="server" meta:resourcekey="lblNoResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_MLCNo" runat="server" Text="MLC No" meta:resourcekey="Rs_MLCNoResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblMLCNo" runat="server" meta:resourcekey="lblMLCNoResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_ModeofPayment" runat="server" Text="Mode of Payment" meta:resourcekey="Rs_ModeofPaymentResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3" style="font-weight: bold">
                        <asp:Label ID="lblIndividual" Text="Individual" runat="server" meta:resourcekey="lblIndividualResource1"></asp:Label>
                        /
                        <asp:Label ID="lblInsurance" Text="Insurance" runat="server" meta:resourcekey="lblInsuranceResource1"></asp:Label>
                        /
                        <asp:Label ID="lblCorporate" Text="Corporate" runat="server" meta:resourcekey="lblCorporateResource1"></asp:Label>
                        /
                        <asp:Label ID="lblOtheRs" Text="If OtheRs(Please Specify)" runat="server" meta:resourcekey="lblOtheRsResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" style="font-weight: bold;" height="70px" rowspan="2">
                        <asp:Label ID="Rs_FinalDiagnosis" runat="server" Text="Final Diagnosis" meta:resourcekey="Rs_FinalDiagnosisResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="2" rowspan="2">
                        <asp:Label ID="lblFinalDiagnosis" runat="server" meta:resourcekey="lblFinalDiagnosisResource1"></asp:Label>&nbsp;
                    </td>
                    <td align="center" nowrap="nowrap" style="font-weight: bold;">
                        <asp:Label ID="Rs_ICDCode" runat="server" Text="ICD Code" meta:resourcekey="Rs_ICDCodeResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="Label4" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold" height="70px" rowspan="2">
                        <asp:Label ID="Rs_OperativeProcedures" runat="server" Text="Operative Procedures"
                            meta:resourcekey="Rs_OperativeProceduresResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="2" rowspan="2">
                        <asp:Label ID="lblOperativeProcedures" runat="server" meta:resourcekey="lblOperativeProceduresResource1"></asp:Label>&nbsp;
                    </td>
                    <td align="center" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_ICPCode" runat="server" Text="ICP Code" meta:resourcekey="Rs_ICPCodeResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="Label5" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" style="font-weight: bold; font-size: 16px" colspan="4" height="35">
                        <u>
                            <asp:Label ID="Rs_DISCHARGESTATUS" runat="server" Text="DISCHARGE STATUS" meta:resourcekey="Rs_DISCHARGESTATUSResource1"></asp:Label></u>
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold" class="style1">
                        <asp:Label ID="Rs_PatientStatusatthe" runat="server" Text="Patient Status at the"
                            meta:resourcekey="Rs_PatientStatusattheResource1"></asp:Label>
                        <br />
                        <asp:Label ID="Rs_TimeofDischarge" runat="server" Text="Time of Discharge" meta:resourcekey="Rs_TimeofDischargeResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" colspan="3" style="font-weight: bold">
                        <asp:Label ID="lblCured" Text="Cured" runat="server" meta:resourcekey="lblCuredResource1"></asp:Label>
                        /
                        <asp:Label ID="lblImproved" Text="Improved" runat="server" meta:resourcekey="lblImprovedResource1"></asp:Label>
                        /
                        <asp:Label ID="lblUnChanged" Text="UnChanged" runat="server" meta:resourcekey="lblUnChangedResource1"></asp:Label>
                        /
                        <asp:Label ID="lblAtRequest" Text="AtRequest" runat="server" meta:resourcekey="lblAtRequestResource1"></asp:Label>
                        /
                        <asp:Label ID="lblAMA" Text="AMA" runat="server" meta:resourcekey="lblAMAResource1"></asp:Label>
                        /
                        <asp:Label ID="lblExpired" Text="Expired" runat="server" meta:resourcekey="lblExpiredResource1"></asp:Label>
                        /
                        <asp:Label ID="lbl" Text="Referred" runat="server" meta:resourcekey="lblResource1"></asp:Label>
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_DischargedByDMO" runat="server" Text="Discharged By (DMO)" meta:resourcekey="Rs_DischargedByDMOResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <span>
                            <asp:Label ID="lblDischargedByDMO" runat="server" meta:resourcekey="lblDischargedByDMOResource1"></asp:Label>&nbsp;
                        </span>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold" height="35px">
                        <asp:Label ID="Rs_SignatureofDMO" runat="server" Text="Signature of DMO" meta:resourcekey="Rs_SignatureofDMOResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <asp:Label ID="lblSignDMO" runat="server" meta:resourcekey="lblSignDMOResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_NameofDutyWardNuRse" runat="server" Text="Name of Duty Ward NuRse"
                            meta:resourcekey="Rs_NameofDutyWardNuRseResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap">
                        <span>
                            <asp:Label ID="lblNameofWardNuRse" runat="server" meta:resourcekey="lblNameofWardNuRseResource1"></asp:Label>&nbsp;
                        </span>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        <asp:Label ID="Rs_SignatureofDutyWardNuRse" runat="server" Text="Signature of Duty Ward NuRse"
                            meta:resourcekey="Rs_SignatureofDutyWardNuRseResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" height="35px">
                        <asp:Label ID="lblSignofWardNuRse" runat="server" meta:resourcekey="lblSignofWardNuRseResource1"></asp:Label>&nbsp;
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr class="rowHeight">
                    <td align="center" style="font-weight: bold; font-size: 16px" colspan="4" height="35">
                        <u>
                            <asp:Label ID="Rs_REPORTSISSUED" runat="server" Text="REPORTS ISSUED" meta:resourcekey="Rs_REPORTSISSUEDResource1"></asp:Label></u>
                    </td>
                </tr>
                <tr class="rowHeight" height="10">
                    <%--<td colspan="6" align="center">
                    
                        <asp:CheckBoxList CssClass="fontSizes"  RepeatColumns="3" RepeatDirection="Horizontal"
                            ID="chklstReportsIssued" runat="server">
                            <asp:ListItem Text="DISCHARGE SUMMARY"></asp:ListItem>
                            <asp:ListItem Text="ECHO"></asp:ListItem>
                            <asp:ListItem Text="INVESTIGATION REPORTS"></asp:ListItem>
                            <asp:ListItem Text="USG REPORT"></asp:ListItem>
                            <asp:ListItem Text="ECG"></asp:ListItem>
                            <asp:ListItem Text="X-RAY FILM WITHOUT REPORT"></asp:ListItem>
                            <asp:ListItem Text="IF OTHER PLEASE SPECIFY"></asp:ListItem>
                        </asp:CheckBoxList>
                        <br />
                    </td>--%>
                    <td>
                        <asp:CheckBox Text="DISCHARGE SUMMARY" ID="CheckBox3" runat="server" meta:resourcekey="CheckBox3Resource1" />
                    </td>
                    <td colspan="2">
                        <asp:CheckBox Text="Blood Investigation" ID="Checkbox7" runat="server" meta:resourcekey="Checkbox7Resource1" />
                    </td>
                    <td>
                        <asp:CheckBox Text="USG REPORT" ID="CheckBox2" runat="server" meta:resourcekey="CheckBox2Resource1" />
                    </td>
                </tr>
                <tr height="10">
                    <td>
                        <asp:CheckBox Text="X-RAY FILM WITH REPORT" ID="CheckBox5" runat="server" meta:resourcekey="CheckBox5Resource1" />
                    </td>
                    <td colspan="2">
                        <asp:CheckBox Text="ECG" ID="CheckBox4" runat="server" meta:resourcekey="CheckBox4Resource1" />
                    </td>
                    <td>
                        <asp:CheckBox Text="ECHO" ID="chk1" runat="server" meta:resourcekey="chk1Resource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:CheckBox Text="IF OTHER PLEASE SPECIFY" ID="CheckBox6" runat="server" meta:resourcekey="CheckBox6Resource1" />
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold" height="10" colspan="2">
                        <asp:Label ID="Rs_ReportsIssuedBy" runat="server" Text="Reports Issued By :" meta:resourcekey="Rs_ReportsIssuedByResource1"></asp:Label>
                        <br />
                        <asp:Label ID="Rs_NameInCapital1" Text="(NAME IN CAPITAL)" Font-Size="8px" runat="server"
                            meta:resourcekey="Rs_NameInCapital1Resource1" />
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold;">
                        <asp:Label ID="Rs_DateTime" runat="server" Text="Date&Time :" meta:resourcekey="Rs_DateTimeResource1"></asp:Label>
                    </td>
                    <td align="left" nowrap="nowrap" style="font-weight: bold">
                        &nbsp;
                    </td>
                </tr>
                <tr class="rowHeight">
                    <td align="left" nowrap="nowrap" style="font-weight: bold" height="60" colspan="4">
                        <asp:Label ID="Rs_ReportsReceivedBy" runat="server" Text="Reports Received By :"
                            meta:resourcekey="Rs_ReportsReceivedByResource1"></asp:Label>
                        <br />
                        <asp:Label ID="Rs_NAMEINCAPITAL2" runat="server" Font-Size="8px" Text="(NAME IN CAPITAL)"
                            meta:resourcekey="Rs_NAMEINCAPITAL2Resource1"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="Rs_RelationshiptoPatient" runat="server" Text="Relationship to Patient :"
                            meta:resourcekey="Rs_RelationshiptoPatientResource1"></asp:Label>
                        <br />
                    </td>
                </tr>
                <%--<tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                    <hr style="color: Black; height: 0.1px;" />
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap" colspan="6">
                        &nbsp;</td>
                </tr>--%>
            </table>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
