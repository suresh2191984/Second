<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MethodKitCapture.aspx.cs"
    Inherits="Investigation_MethodKitCapture" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails" TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/MethodKitMapping.ascx" TagName="MethodKitCapture"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Method, Kit &amp; Instrument Capture</title>
</head>
<body oncontextmenu="return true;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                    <div runat="server" id="divPatientDetails" >
                            
                           <ucPatientdet:PatientDetails id="PatientDetail" runat="server" />
                    </div>
                        <uc7:MethodKitCapture ID="ucMethodKitCapture" runat="server" />
                        <table class="w-100p searchPanel">
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="Back" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" />
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Save & Continue" OnClick="btnSave_Click" />
                                    <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Cancel" OnClick="Button1_Click" />
                                </td>
                            </tr>
                            <tr>
                            <td>&nbsp;</td>
                            </tr>
                        </table>
                        
                        <input id="hdnHeaderName" runat="server" type="hidden" value="0" />
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />           
    </form>

    <script language="javascript" type="text/javascript">
        LoadExistingMethodKit();
    </script>

</body>
</html>
