<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewSamples.aspx.cs" Inherits="Admin_ViewSamples" %>

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
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Sample Collection Report</title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

</head>
<body runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                                Look up for Sample Details
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    Patient No:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    Patient Name:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    Gender:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    Age:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    Visit No:
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="grdResult" Width="99%" runat="server" AllowPaging="True" CellPadding="4"
                                        AutoGenerateColumns="False" PagerSettings-Mode="NextPrevious" ForeColor="#333333"
                                        PageSize="10" GridLines="Both" CssClass="mytable1" OnPageIndexChanging="grdResult_PageIndexChanging">
                                        <PagerTemplate>
                                            <tr>
                                                <td colspan="6" align="center">
                                                    <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                                    <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                                </td>
                                            </tr>
                                        </PagerTemplate>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="SampleDesc" Visible="true" HeaderText="Sample" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="30%" />
                                            <asp:BoundField DataField="InvSampleStatusDesc" Visible="true" HeaderText="Status"
                                                HeaderStyle-HorizontalAlign="left" ItemStyle-Width="20%" />
                                            <asp:BoundField DataField="DeptName" Visible="true" HeaderText="Department" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="30%" />
                                            <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                Visible="true" HeaderText="Date" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left"
                                                ItemStyle-Width="20%" />
                                        </Columns>
                                    </asp:GridView>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button runat="server" ID="btnGo" Text="Back" CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
