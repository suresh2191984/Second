<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NotesPattern.ascx.cs"
    Inherits="Investigation_NotesPattern" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>--%>
<style type="text/css" media="print">
    #listTable tfoot
    {
        display: table-footer-group;
    }
    #listTable thead
    {
        display: table-header-group;
    }
</style>
<table style="display: none;">
    <tr>
        <td class="a-center">
            <FCKeditorV2:FCKeditor ID="fckInvDetails" runat="server" Width="800px" Height="500px">
            </FCKeditorV2:FCKeditor>
            <%-- <CKEditor:CKEditorControl ID="CKEditor1" runat="server" Height="600px" Width="700px" 
                ContentsCss="../ckeditor/contents.css" 
                TemplatesFiles="../ckeditor/plugins/templates/templates/default.js"></CKEditor:CKEditorControl>--%>
        </td>
    </tr>
</table>
<br />
<br />
<br />
<br />
<br />
<br />
<table id="listTable" class="w-100p">
<thead>
   <tr>
        <th class="a-left w-80">
            <b>
                <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
                <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
        <th>
        &nbsp;
        </th>
        <th class="a-left" style="width:130px;">
            <b>
                <asp:Label ID="Rs_RegisterOn" Text="Reg. Date/Time" runat="server" meta:resourcekey="Rs_RegisterOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left" style="width:140px;">
            <asp:Label ID="lblVisitDate" runat="server" meta:resourcekey="lblVisitDateResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
        <th class="w-10" rowspan="5">
            <div style="font-family:Trebuchet MS;font-size:13px;">
            R<br />E<br />P<br />O<br />R<br />T
            </div>
        </th>
    </tr>
    <tr>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_PIDNo" Text="Perm No." runat="server" meta:resourcekey="Rs_PIDNoResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblPatientID" runat="server" meta:resourcekey="lblPatientIDResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
        <th>
        &nbsp;
        </th>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_CollectionOn" Text="Reported Date/Time" runat="server" meta:resourcekey="Rs_CollectionOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblCollectedOn" runat="server" meta:resourcekey="lblCollectedOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
    </tr>
    <tr>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_SIDNo" Text="Visit No." runat="server" meta:resourcekey="Rs_SIDNoResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
        <th>
        &nbsp;
        </th>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_ReportOn" Text="Printed Date/Time" runat="server" meta:resourcekey="Rs_ReportOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblReportedOn" runat="server" meta:resourcekey="lblReportedOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
    </tr>
    <tr>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_AgeSex" Text="Gender/Age" runat="server" meta:resourcekey="Rs_AgeSexResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblAgeSex" runat="server" meta:resourcekey="lblAgeSexResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
        <th>
        &nbsp;
        </th>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_PrintedOn" Text="Ref. Client" runat="server" meta:resourcekey="Rs_PrintedOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblPrintedOn" runat="server" meta:resourcekey="lblPrintedOnResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
    </tr>
    <tr>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_RefDr" Text="Ref. Dr." runat="server" meta:resourcekey="Rs_RefDrResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="a-center w-10">:</th>
        <th class="a-left">
            <b>
                <asp:Label ID="lblReferingPhysicianName" runat="server" meta:resourcekey="lblReferingPhysicianNameResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th>
        &nbsp;
        </th>
        <th class="a-left">
            <b>
                <asp:Label ID="Rs_OPIP" Text="Ref. Hospital" runat="server" meta:resourcekey="Rs_OPIPResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label></b>
        </th>
        <th class="center w-10">:</th>
        <th class="a-left">
            <asp:Label ID="lblVisitType" runat="server" meta:resourcekey="lblVisitTypeResource1" Font-Names="Trebuchet MS" Font-Size="13px"></asp:Label>
        </th>
    </tr>
    <tr>
        <th colspan="8">
            <hr />
        </th>
    </tr>
    </thead>
    <tbody>
<%--    <tr>
        <td colspan="8" class="center">
            <asp:Label ID="lblInvestigationName" runat="server" Font-Bold="True" Font-Size="Medium" Font-Underline="true"
                meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
        </td>
    </tr>--%>
    <tr>
        <td colspan="8">
            <asp:Literal ID="ltrlDescription" runat="server" meta:resourcekey="ltrlDescriptionResource1"></asp:Literal>
        </td>
    </tr>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="3">
            &nbsp;
        </td>
        <td colspan="3">
            &nbsp;
        </td>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="3">
        &nbsp;
        </td>
        <td colspan="3">
        <div style="text-align:right;font-family:Trebuchet MS;font-size:12px;">
        <img id="img1" src="s" runat="server" width="154" height="37" />
        </div>
        </td>
        <td colspan="2">
        &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Label ID="lblTechnician1" runat="server" Visible="False" Font-Bold="True" 
                meta:resourcekey="lblTechnician1Resource1" />
        </td>
        <td colspan="3">
        <div style="text-align:right;font-family:Trebuchet MS;font-size:12px;">
                <asp:Label ID="lblTechnician" runat="server" Visible="False" Font-Bold="True" 
                meta:resourcekey="lblTechnicianResource1" Font-Names="Trebuchet MS" Font-Size="12px" /><br />
                <asp:Label ID="lblTechnicianTitle" runat="server" Visible="False" 
                meta:resourcekey="lblTechnicianResource1" Font-Names="Trebuchet MS" 
                    Font-Size="12px" />
            </div>
            
        </td>
       <%-- <td colspan="2">
            <div style="text-align:right;font-family:Trebuchet MS;font-size:12px;">
                <b>DR. SANJAY ARORA</b><br />M.D. (PATH), D.P.B<br />LAB DIRECTOR
            </div>
        </td>--%>
    </tr>
    <tr>
        <%--<td colspan="3">
            <asp:Label ID="Rs_Info" Text="Quality controlled report with external quality assurance." 
                runat="server" meta:resourcekey="Rs_InfoResource1" Font-Names="Trebuchet MS" Font-Size="12px" Font-Italic="true"></asp:Label>
        </td>--%>
        <td colspan="3">
        &nbsp;
        </td>
        <td colspan="2">
        <asp:Label ID="lblTechnician2" runat="server" Visible="False" Font-Bold="True" 
                meta:resourcekey="lblTechnician2Resource1" />
        </td>
    </tr>
    </tfoot>
</table>
