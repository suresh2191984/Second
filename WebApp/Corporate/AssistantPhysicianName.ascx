<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AssistantPhysicianName.ascx.cs" Inherits="Corporate_AssistantPhysicianName" %>

<table>
<tr>
    <td>
       <asp:Label Text="Prescription By" runat="server" ID="lblPrescription" 
            meta:resourcekey="lblPrescriptionResource1"></asp:Label>
    </td>
    <td>
        <asp:DropDownList ID="drpPhysician" runat="server" 
            meta:resourcekey="drpPhysicianResource1" CssClass="ddlsmall">
        </asp:DropDownList>
    </td>
    <asp:HiddenField ID="hdnphysician" runat="server" />
</tr>
</table>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />