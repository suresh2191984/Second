<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagePackage.aspx.cs" Inherits="Admin_ManagePackage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Src="../CommonControls/PackageProfileControl1.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                    
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <uc9:PackageProfileControl ID="PackageProfileControl" runat="server" />
                                </td>
                            </tr>
                            <tr runat="server" style="display: table-row;" id="submitTab">
                                <td>
                                    <asp:Button ID="btnFinish" runat="server" OnClick="btnFinish_Click" Text="Save" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        CommandName="Clear" />
                                </td>
                            </tr>
                        </table>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />               
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
