<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MasterBulkdata.aspx.cs" Inherits="MasterBulkdata" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc112" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Master data Bulk Load</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function checkDetails() {
            alert(document.getElementById('fulSelect').value);
            return false;
        }

    </script>

</head>
<body >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
       <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc112:Header ID="ReceptionHeader" runat="server" />
           </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
              
       <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <asp:UpdatePanel ID="pnl" runat="server">
                            <ContentTemplate>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <table style="font-weight: normal; color: #000000;" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_SelectFile" Text="Select File :" runat="server" 
                                                meta:resourcekey="Rs_SelectFileResource1"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;
                                            <asp:FileUpload ID="fulSelect" runat="server" 
                                                meta:resourcekey="fulSelectResource1" />
                                        </td>
                                        <td>
                                            <asp:Button ID="BtnSheet" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Text="Upload" OnClick="BtnSheet_Click" 
                                                meta:resourcekey="BtnSheetResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 10px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div id="Sheet" runat="server">
                                                <asp:Label ID="Rs_SelectSheet" Text="Select Sheet:" runat="server" 
                                                    meta:resourcekey="Rs_SelectSheetResource1"></asp:Label>
                                                <asp:DropDownList ID="ddlSheet" runat="server" CssClass="ddlsmall"
                                                    meta:resourcekey="ddlSheetResource1">
                                                <asp:ListItem meta:resourcekey="ListItemResource1" Text="Select"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Text="Save" OnClick="btnSave_Click" 
                                                meta:resourcekey="btnSaveResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 10px;">
                                            <asp:HiddenField ID="hdnFilePath" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                    <td colspan="3">
                                    <asp:Label ID="lblTest" runat ="server"  Visible="False" Font-Bold="True" 
                                            ForeColor="Orange" meta:resourcekey="lblTestResource1" ></asp:Label>
                                    </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="BtnSheet" />
                                <asp:AsyncPostBackTrigger ControlID="btnSave" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
