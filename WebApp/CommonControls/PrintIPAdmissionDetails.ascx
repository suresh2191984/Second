<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintIPAdmissionDetails.ascx.cs"
    Inherits="CommonControls_PrintIPAdmissionDetails" %>
<%--<table width="500px" id="tblIPAdmissionDetailsPrint" runat="server">
<tr><td>--%>
<style type="text/css">
    .fontSizes
    {
        font-size: 12px;
        font-family: Verdana, Arial;
    }
</style>
<table width="500px" class="a-left">
    <tr>
        <%--<td>
            &nbsp;
        </td>--%>
        <td>
            <table width="500px" class="fontSizes a-left">
                <tr>
                    <td class="a-left" nowrap="nowrap" colspan="6">
                        <asp:Label ID="lblOrganizationName" runat="server" Style="font-weight: bold; font-size: 16px;"
                            meta:resourcekey="lblOrganizationNameResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap" colspan="6">
                        <asp:Label ID="lblOrgAddress" runat="server" Style="font-weight: bold;" meta:resourcekey="lblOrgAddressResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap" colspan="6">
                        <hr style="color: Black; height: 0.5px;" />
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_Patient_ID" runat="server" Text="Patient ID" meta:resourcekey="Rs_Patient_IDResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <span>
                            <asp:Label ID="lblPatientNumber" runat="server" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                        </span>
                    </td>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_IP_No" runat="server" Text="IP No" meta:resourcekey="Rs_IP_NoResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;:&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblIPNo" runat="server" meta:resourcekey="lblIPNoResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_Pat_Name" runat="server" Text="Patient Name" meta:resourcekey="Rs_Pat_NameResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <span>
                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                        </span>
                    </td>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_AgeSex" runat="server" Text="Age / Sex" meta:resourcekey="Rs_AgeSexResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                        /
                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_VisitType" runat="server" Text="Visit Type" meta:resourcekey="Rs_VisitTypeResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblVisitType" runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                    </td>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_DateTime" runat="server" Text="Date Time" meta:resourcekey="Rs_DateTimeResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblDateTime" runat="server" meta:resourcekey="lblDateTimeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="Rs_Mobile" runat="server" Text="Mobile" meta:resourcekey="Rs_MobileResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;:&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblMobile" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label>
                    </td>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_LandLine" runat="server" Text="LandLine" meta:resourcekey="Rs_LandLineResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;:&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblLLNo" runat="server" meta:resourcekey="lblLLNoResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_Address" runat="server" Text="Address" meta:resourcekey="Rs_AddressResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" colspan="4">
                        <asp:Label ID="lblAddress" runat="server" meta:resourcekey="lblAddressResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_MedicalOfficer" runat="server" Text="Medical Duty Officer" meta:resourcekey="Rs_MedicalOfficerResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblMedicalDutyOfficer" runat="server" meta:resourcekey="lblMedicalDutyOfficerResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left bold" nowrap="nowrap">
                        <asp:Label ID="Rs_Consultant" runat="server" Text="Consultant" meta:resourcekey="Rs_ConsultantResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; :&nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblRefPhysician" runat="server" meta:resourcekey="lblRefPhysicianResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                    </td>
                    <td class="a-left" nowrap="nowrap">
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap" style="font-weight: bold">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp; &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblConsultant" Visible="False" runat="server" meta:resourcekey="lblConsultantResource1"></asp:Label>
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                    <td class="a-left" nowrap="nowrap">
                    </td>
                    <td class="a-left" nowrap="nowrap">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left" nowrap="nowrap" colspan="6">
                        <%--<hr />--%>
                    </td>
                </tr>
            </table>
            <%--<table width="90%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" nowrap="nowrap" colspan="6">
                        <asp:Label ID="lblOrgName" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        <label>
                            Patient Name</label></td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp; :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <span style="width: 23%">
                            <asp:Label ID="lblName" runat="server" style="font-weight: 700"></asp:Label>
                        </span>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
                        Patient No</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <span style="width: 23%">
                        <asp:Label ID="lblPatientNumber" runat="server" style="font-weight: 700"></asp:Label>
                        </span></td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Patient DOB
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblDOB" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          Sex</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblSex" runat="server" style="font-weight: 700"></asp:Label>                    
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Patient Age
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblAge" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          Blood Group</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblBloodGroup" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Admission Date
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblAdmissionDate" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          AccompaniedBy</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblAccBy" runat="server"  style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Relationship
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblRelation" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
                          Contact No</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblRelContactNo" runat="server"  style="font-weight: 700"></asp:Label>    
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Emergency No.
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblEmergencyCNo" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          Pat Condition</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblCondition" runat="server"  style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Purpose
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblPOA" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Primary Physician
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblPrimaryPhysician" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          Speciality</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;:&nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblSpecialityName" runat="server" style="font-weight: 700"></asp:Label>                    
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        ConsultingSurgeon
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblConsultingSurgeon" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
 
                          IP No</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        <asp:Label ID="lblIPNo" runat="server" style="font-weight: 700"></asp:Label></td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        Knowledgeservice
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblKnowledgeOfServiceName" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        ServiceProvider
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td align="left" nowrap="nowrap" colspan="3">
                        <asp:Label ID="lblServiceProviderName" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                    <td width="83%" align="left" nowrap="nowrap">
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        InformationBy
                       </td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;
                        :</td>
                    <td align="left" nowrap="nowrap" colspan="4">
                        <asp:Label ID="lblInformationBy" runat="server" style="font-weight: 700"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td align="left" nowrap="nowrap" class="style1">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                    <td width="83%" align="left" nowrap="nowrap">
                        &nbsp;</td>
                </tr>
                </table>--%>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<%-- </td></tr></table>--%>