<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAccessHeader.ascx.cs"
    Inherits="CommonControls_PatientMainHeaderl" %>
<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
<div>
    <table height="45px" style="margin-left: -2px" border="0" cellspacing="0" cellpadding="0"
        class="details1">
        <tr>
            <td width="2%">
            </td>
            <td width="65%">
                <table border="0" cellpadding="0" cellspacing="0" width="50%">
                    <tr>
                        <td width="">
                            <asp:Label ID="Rs_Name" runat="server" Text="Name" meta:resourcekey="Rs_NameResource1" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                        </td>
                        <td width="20%">
                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                        </td>
                        <td width="8%">
                            <asp:Label ID="Rs_Age" runat="server" Text="Age" meta:resourcekey="Rs_AgeResource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                            :
                        </td>
                        <td width="7%">
                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td width="8%">
                            <asp:Label ID="Rs_BloodGroup" runat="server" Text="Blood Group" meta:resourcekey="Rs_BloodGroupResource1" />&nbsp;&nbsp;
                            :
                        </td>
                        <td width="8%">
                            <asp:Label ID="lblBloodGroup" runat="server" meta:resourcekey="lblBloodGroupResource1"></asp:Label>
                        </td>
                        <td width="5%">
                            <asp:Label ID="Rs_URNo" runat="server" Text="URNo" meta:resourcekey="Rs_URNoResource1" />&nbsp;&nbsp;
                            :
                        </td>
                        <td width="7%">
                            <asp:Label ID="lblURNo" Text="--" runat="server" meta:resourcekey="lblURNoResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="2%">
                &nbsp;
            </td>
        </tr>
    </table>
</div>
