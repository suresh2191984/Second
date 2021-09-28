<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientOldNotesViewer.ascx.cs"
    Inherits="CommonControls_PatientOldNotesViewer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Src="FileDataViewer.ascx" TagName="FileViewer" TagPrefix="uc1" %>
<table>
    <tr>
        <td align="center" width="650px" style="font-weight:bold;">
            <h2>
                <asp:Label runat="server" ID="lblTitle" 
                    Text="No title provided for this document" meta:resourcekey="lblTitleResource1"></asp:Label>
            </h2>
        </td>
    </tr>
    <tr>
        <td width="650px" align="center">
            <uc1:FileViewer ID="viewData" runat="server" />
        </td>
    </tr>
</table>
