<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintRecommendation.aspx.cs"
    Inherits="Patient_PrintRecommendation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>PrintRecommendation</title>
    <%--<link href="~/StyleSheets/Style.css" rel="stylesheet" type="text/css" />
--%>
    <script src="/Scripts/bid.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('PrintPackage');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 63px;
        }
    </style>
</head>
<body  oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
         <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
          </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <ul>
                            <li class="dataheader">Recommendations</li>
                        </ul>
                    
                     <table border="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="right">
                             <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="btnBack_Click" 
                                    meta:resourcekey="btnBackResource1" />
                            </td>                            
                        </tr>
                        </table>
                        <asp:UpdatePanel ID="ctlTaskUpdPnl" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvReckon" EmptyDataText="No matching records found " runat="server"
                                    AutoGenerateColumns="False" GridLines="Both" Width="90%" AllowPaging="false"
                                    OnRowCommand="gvReckon_RowCommand" ForeColor="#333333" CellPadding="3" Font-Size="9pt">
                                    <Columns>
                                        <asp:BoundField HeaderText="SeqNo" DataField="SequenceNo" />
                                        <asp:BoundField HeaderText="Recommendations" DataField="ResultValues" />
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                    CommandName="UP" />
                                                <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                    CommandName="DOWN" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <%--<div id="PrintPackage">
                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td>
                                        PatientNo:<asp:Label ID="lblpatientNo" runat="server">
                                        </asp:Label>
                                    </td>
                                    <td>
                                        PatientName:<asp:Label ID="lblname" runat="server">
                                        </asp:Label>
                                    </td>
                                    <td>
                                        Age:<asp:Label ID="lblage" runat="server">
                                        </asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                <tr style="height: 10px;">
                                    <td style="font-weight: normal; color: #000;">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </div>--%>
                        <table width="100%" cellpadding="5" id="tprint" runat="server" cellspacing="0" border="0">
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" 
                                        meta:resourcekey="btnEditResource1" Width="49px" />
                                
                               
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" Width="57px" />
                               
                               
                                    <asp:Button ID="btnComplete" runat="server" Text="Save & Complete" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" OnClick="btnComplete_Click" 
                                        meta:resourcekey="btnCompleteResource1" Width="143px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    
    </form>
</body>
</html>
