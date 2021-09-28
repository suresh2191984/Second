<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Speciality.aspx.cs" Inherits="Admin_Speciality" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Speciality</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function pageLoadFocus(focusID) {
            if (document.getElementById(focusID).value == '') {
                document.getElementById(focusID).focus();
            }
        }

        function validate(ID) {
            if (document.getElementById(ID).value == '') {
                alert("Provide Speciality Name");
                document.getElementById(ID).focus();
                return false;
            }
        }
    </script>
</head>
<body onload="pageLoadFocus('txtSearch');">
    <form id="speciality" runat="server">
        <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
            <div id="wrapper">
                <div id="header">
                    <div class="logoleft" style="z-index: 2;">
                        <div class="logowrapper">
                            <img alt="" src="<%=LogoPath%>" class="logostyle" />
                        </div>
                    </div>
                    <div class="middleheader">
                        <uc4:MainHeader ID="MainHeader1" runat="server" />
                        <uc7:AdminHeader ID="AdminHeader" runat="server" />
                    </div>
                    <div style="float: right;" class="Rightheader">
                    </div>
                </div>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
                        <tr>
                            <td width="15%" valign="top" id="menu" style="display: block;">
                                <div id="navigation">
                                    <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                                </div>
                            </td>
                            <td width="85%" valign="top" class="tdspace">
                                <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                    style="cursor: pointer;" />
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <Top:TopHeader ID="TopHeader1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <div class="contentdata1">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                             <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                             <table border="0" cellpadding="2" cellspacing="1" width="100%" align="center">
                                                <tr>
                                                    <td height="32">
                                                        <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="center" style="font-size:small;color:Blue">
                                                                    <asp:Label ID="lblstatus" runat="server" meta:resourcekey="lblstatusResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                         </table>
                                                     </td>
                                                 </tr>
                                                 <tr>
                                                    <td>
                                                        <asp:Panel ID="pnlSearch" runat="server" BorderWidth="1px" 
                                                            CssClass="dataheader2" meta:resourcekey="pnlSearchResource1">
                                                            <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                                <tr>
                                                                   <td align="right" width="44%">
                                                                        <asp:Label ID="lblSearch" runat="server" Text="Enter To Search Speciality Name" 
                                                                            meta:resourcekey="lblSearchResource1"></asp:Label>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <asp:TextBox ID="txtSearch" runat="server"  CssClass="Txtboxlarge"
                                                                            meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td width="75%">
                                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                                                            onmouseover="this.className='btn btnhov'" 
                                                                            onmouseout="this.className='btn'" OnClientClick="return validate('txtSearch');"
                                                                            CssClass="btn" meta:resourcekey="btnSearchResource1" 
                                                                            onclick="btnSearch_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                         </asp:Panel> 
                                                    </td>
                                                 </tr> 
                                                 <tr>
                                                     <td>
                                                        <asp:HiddenField ID="hdnSpecialityID" runat="server" />
                                                        <asp:HiddenField ID="hdnOrganizationId" runat="server" />
                                                         <hr />
                                                         <br />
                                                         <asp:Panel ID="pnlEnter" runat="server" BorderWidth="1px" 
                                                             CssClass="dataheader2" meta:resourcekey="pnlEnterResource1">
                                                             <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                 <tr>
                                                                     <td style="padding: 3px;">
                                                                         <table border="0" cellpadding="3" cellspacing="1" width="100%">
                                                                             <tr>
                                                                                 <td align="right" width="35%">
                                                                                     <asp:Label ID="lblSpecialityName" runat="server" 
                                                                                         Text="Enter Speciality Name" meta:resourcekey="lblSpecialityNameResource1"></asp:Label>
                                                                                 </td>
                                                                                 <td width="45%">
                                                                                     <asp:TextBox ID="txtSpecialityName" runat="server" AutoComplete="off" 
                                                                                           CssClass ="Txtboxlarge" meta:resourcekey="txtSpecialityNameResource1"></asp:TextBox>
                                                                                 </td>
                                                                             </tr>
                                                                             <tr>
                                                                                 <td align="center" colspan="2">
                                                                                     <asp:Button ID="btnSave" runat="server" CssClass="btn"                                                                                                          
                                                                                         onmouseout="this.className='btn'" 
                                                                                         onmouseover="this.className='btn btnhov'" Text="Save" 
                                                                                         OnClientClick="return validate('txtSpecialityName');"
                                                                                         ToolTip="Click Here to Save SpecialityName" Width="10%" 
                                                                                         meta:resourcekey="btnSaveResource1" onclick="btnSave_Click" />
                                                                                     &nbsp;
                                                                                     <asp:Button ID="btnCancel" runat="server" CssClass="btn"                                                                                                          
                                                                                         onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                                         Text="Cancel" ToolTip="Click To Cancel" Width="10%" 
                                                                                         meta:resourcekey="btnCancelResource1" onclick="btnCancel_Click" />
                                                                                     &nbsp;
                                                                                     <asp:Button ID="btnRefresh" runat="server" CssClass="btn"                                                                                                         
                                                                                         onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                                         Text="Refresh" ToolTip="Click Here To Refresh" Width="10%" 
                                                                                         meta:resourcekey="btnRefreshResource1" onclick="btnRefresh_Click" />
                                                                                 </td>
                                                                             </tr>
                                                                         </table>
                                                                     </td>
                                                                 </tr>
                                                             </table>
                                                         </asp:Panel>
                                                     </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" style="padding-bottom: 10px;">
                                                        <asp:GridView ID="grdView" runat="server" AutoGenerateColumns="False" 
                                                            AllowPaging="True" CellPadding="4" CssClass="mytable"
                                                            DataKeyNames="SpecialityID,SpecialityName"
                                                            OnRowCommand="grdView_RowCommand" OnRowDataBound="grdView_RowDataBound"
                                                            PageSize="200" Width="50%" meta:resourcekey="grdViewResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <PagerSettings Mode="NextPrevious" />
                                                            <Columns>
                                                                 <asp:BoundField DataField="SpecialityID" HeaderText="SpecialityID" 
                                                                     Visible="False" meta:resourcekey="BoundFieldResource1">
                                                                     <HeaderStyle HorizontalAlign="Left" />
                                                                     <ItemStyle HorizontalAlign="Left" Width="250px" />
                                                                 </asp:BoundField>
                                                                 <asp:BoundField DataField="SpecialityName" HeaderText="Speciality Name" 
                                                                     meta:resourcekey="BoundFieldResource2">
                                                                     <HeaderStyle HorizontalAlign="Left" />
                                                                     <ItemStyle HorizontalAlign="Left" />
                                                                 </asp:BoundField>
                                                            </Columns>
                                                            <SelectedRowStyle ForeColor="#000066" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>                                                                                                        
                                             </table>
                                         </ContentTemplate>
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
