<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferedInvestigation.ascx.cs"
    Inherits="CommonControls_ReferedInvestigation" %>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
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
            <asp:Label ID="Rs_RefbyName" runat="server" Text="Ref. by Name:" meta:resourcekey="Rs_RefbyNameResource1"></asp:Label>
            <asp:Label ID="lblPhysicianName" runat="server" meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
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
            <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name:" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
            <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_Age" runat="server" Text=" Age:" meta:resourcekey="Rs_AgeResource1"></asp:Label>
            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_Sex" runat="server" Text="Sex:" meta:resourcekey="Rs_SexResource1"></asp:Label>
            <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_IamherewithsendingaPatientToYourCentreForTheFollowingInvestigations"
                runat="server" Text="I am here with sending a patient to your centre for the following investigations:"
                meta:resourcekey="Rs_IamherewithsendingaPatientToYourCentreForTheFollowingInvestigationsResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="gvReferedInvestigation" CellPadding="2" CellSpacing="3" runat="server"
                AutoGenerateColumns="False" Width="100%" meta:resourcekey="gvReferedInvestigationResource1">
                <Columns>
                    <asp:BoundField HeaderText="Sno" DataField="ID" meta:resourcekey="BoundFieldResource1" />
                    <asp:BoundField HeaderText="Investigation" DataField="InvestigationName" meta:resourcekey="BoundFieldResource2" />
                    <asp:BoundField HeaderText="Refered Org" Visible="false" DataField="Name" meta:resourcekey="BoundFieldResource3" />
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_KindlyDoTheNeedful" runat="server" Text="Kindly do the needful,"
                meta:resourcekey="Rs_KindlyDoTheNeedfulResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_Awaitingyourreports" runat="server" Text="Awaiting your reports,"
                meta:resourcekey="Rs_AwaitingyourreportsResource1"></asp:Label>
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
