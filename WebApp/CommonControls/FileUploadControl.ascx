<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FileUploadControl.ascx.cs" Inherits="CommonControls_FileUploadControl" %>

<%@ Register src="AddressControl.ascx" tagname="AddressControl" tagprefix="uc1" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<table class="dataheaderk" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table>
            <tr>
                <td>       
                    <asp:Label ID="lblSelect" runat="server" Text="Select File To Upload" 
                        CssClass="tabletxt" meta:resourcekey="lblSelectResource1"></asp:Label>
                </td>
                <td class="uploadstyle">
                    <asp:FileUpload ID="FileUpload1" runat="server" class="uploadstyle" 
                        meta:resourcekey="FileUpload1Resource1"/>
                </td>
            </tr> 
            </table> 
        </td>
    </tr> 
    <tr>
        <td>
            <table> 
                <tr>
                    <td width="200px"> </td>
                   
                </tr>
            </table>
        </td> 
        </tr>
        <tr>
        <td>
            <table >
            <tr>
            <td >
                <asp:Label ID="lblFileUpload" runat="server" CssClass="tabletxt" 
                    meta:resourcekey="lblFileUploadResource1"></asp:Label>
                <asp:Label ID="lblFile" runat="server" CssClass="tabletxt" Visible="False" 
                    meta:resourcekey="lblFileResource1"></asp:Label>
            </td>
        </tr>
        </table> 

        </td> 
       
            </tr>
 </table>
<p>&nbsp;</p>
