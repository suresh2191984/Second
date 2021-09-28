<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddInvandGroups.aspx.cs"
    Inherits="Admin_AddInvandGroups" meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/PackageProfileControl1.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />   --%>
    <%--<link rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:Panel ID="pnlLocation" Width="300px" runat="server" CssClass="modalPopup h-100 dataheaderPopup"
            Style="display: block" meta:resourcekey="pnlLocationResource1">
            <asp:UpdatePanel ID="selectpnl" runat="server">
                <ContentTemplate>
                    <table class="a-center">
                        <tr>
                            <td>
                                <asp:Label ID="Rs_SelecttheOption" Text="Select the Option:" runat="server" meta:resourcekey="Rs_SelecttheOptionResource1"></asp:Label>
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" >
                                    <%--<asp:ListItem Value="INV" Text="Investigation" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Value="GRP" Text="Group" meta:resourcekey="ListItemResource2"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20">
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnOk" style="width:100px;" runat="server" Text="OK" OnClick="btnOk_Click" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnOkResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" TargetControlID="btnDummy"
            PopupControlID="pnlLocation" BackgroundCssClass="modalBackground" DynamicServicePath=""
            Enabled="True" />
        <input type="button" id="btnDummy" runat="server" style="display: none;" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
