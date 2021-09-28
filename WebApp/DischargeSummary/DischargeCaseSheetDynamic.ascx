<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargeCaseSheetDynamic.ascx.cs"
    Inherits="DischargeSummary_DischargeCaseSheetDynamic" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Reference Control="~/DischargeSummary/PatientAddress.ascx" %>
<%@ Reference Control="~/DischargeSummary/PatientDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/ConditionOnDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfAdmission.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/DateOfSurgery.ascx" %>
<%@ Reference Control="~/DischargeSummary/PrimaryConsultant.ascx" %>
<%@ Reference Control="~/DischargeSummary/TypeOfDischarge.ascx" %>
<%@ Reference Control="~/DischargeSummary/Diagnose.ascx" %>
<%@ Reference Control="~/DischargeSummary/TreatmentPlan.ascx" %>
<%@ Reference Control="~/DischargeSummary/History.ascx" %>
<%@ Reference Control="~/DischargeSummary/BackrounMedicalProblem.ascx" %>
<%@ Reference Control="~/DischargeSummary/AdmissionVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/SystemicExamination.ascx" %>
<%@ Reference Control="~/DischargeSummary/DischargeVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/GeneralExamination.ascx" %>
<%@ Reference Control="~/DischargeSummary/SurgeryDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/CourseInHospital.ascx" %>
<%@ Reference Control="~/DischargeSummary/DischargePrescription.ascx" %>
<%@ Reference Control="~/DischargeSummary/Advice.ascx" %>
<%@ Reference Control="~/DischargeSummary/Procedure.ascx" %>
<%@ Reference Control="~/DischargeSummary/ChiefSurgeon.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHAdmissionVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHDischargeVitals.ascx" %>
<%@ Reference Control="~/DischargeSummary/KMHPatientDetails.ascx" %>
<%@ Reference Control="~/DischargeSummary/PostOpInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/PreOpInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/RoutineInv.ascx" %>
<%@ Reference Control="~/DischargeSummary/RoomSummary.ascx" %>
<div id="PrintDischarge">
    <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
        style="display: block;">
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
        <tr id="trPlaceHolder1" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder2" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder3" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder4" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder4" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder5" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder5" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder6" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder6" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder7" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder7" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder8" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder8" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder9" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder9" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder10" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder10" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder11" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder11" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder12" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder12" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder13" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder13" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder14" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder14" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder15" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder15" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder16" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder16" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder18" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder18" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder17" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder17" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder19" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder19" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder20" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder20" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder21" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder21" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr id="trPlaceHolder22" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder22" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
         <tr id="trPlaceHolder23" runat="server" style="display: none">
            <td>
                <asp:PlaceHolder ID="PlaceHolder23" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr id="NextReviewDate" runat="server" style="display: none">
            <td style="font-weight: bold; height: 20px; color: #000;">
                <asp:Label ID="Rs_NEXTREVIEW" Text="NEXT REVIEW -" runat="server" 
                    meta:resourcekey="Rs_NEXTREVIEWResource1"></asp:Label>
                <asp:Label ID="lblNextReview" runat="server" meta:resourcekey="lblNextReviewResource1"></asp:Label>
            </td>
        </tr>
        <tr id="trReviewreason" runat="server" style="display: none">
            <td>
                <asp:Label ID="lblRRH" runat="server" Text="REVIEW REASON -" Font-Bold="True" meta:resourcekey="lblRRHResource1"></asp:Label>
                <asp:Label ID="lblReviewReason" runat="server" meta:resourcekey="lblReviewReasonResource1"></asp:Label>
            </td>
        </tr>
        <tr id="NextReviewNotes" runat="server" style="display: none">
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
                <asp:Label ID="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILE" Text="(INVESTIGATION REPORTS ENCLOSED IN THE FILE)"
                    runat="server" 
                    meta:resourcekey="Rs_INVESTIGATIONREPORTSENCLOSEDINTHEFILEResource1"></asp:Label>
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
                <asp:Label ID="lblSMOT" runat="server" Text="Medical Duty Officer" Visible="False"
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
