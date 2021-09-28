<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PackageProfile.aspx.cs" Inherits="EMR_PackageProfile" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PackageProfileControl.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>

<script language="javascript" type="text/javascript">
    function CallCancelMessage(sender) {
        if (confirm("Are you sure you wish to cancel?")) {

            return true;
        }
        else {

            return false;
        }
    }
</script>

<body>
    <form id="form1" runat="server">
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <uc9:PackageProfileControl ID="PackageProfileControl" runat="server" />
                                </td>
                            </tr>
                            <tr style="display: table-row;" id="submitTab" runat="server">
                                <td class="a-center">
                                    <asp:Button ID="btnFinish" runat="server" OnClick="btnFinish_Click" Text="Save" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnServiceFinish" runat="server" OnClick="btnServiceFinish_Click"
                                        Text="Save & Continue" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Visible="False" 
                                        meta:resourcekey="btnServiceFinishResource1" />
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Visible="False" 
                                        meta:resourcekey="btnBackResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClientClick="javascript:if(!CallCancelMessage(this)) return false;" 
                                        CommandName="Clear" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                 <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
