<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvReports.aspx.cs" Inherits="Investigation_InvReports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateVisitSampleNo() {
            if (document.getElementById('txtVisitSampleNo').value == '') {
                alert('Provide visit or sample number');
                document.getElementById('txtVisitSampleNo').focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="txtVisitSampleNo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" Width="85%" runat="server">
                            <table border="0" id="searchTab" runat="server" cellpadding="4" cellspacing="0" width="100%">
                                <tr>
                                    <td style="font-weight: normal; height: 20px; color: #000; width: 40%;" align="left">
                                        <asp:Label ID="lblSearch" Text="Enter Lab Bill No / Visit No to Search" runat="server"></asp:Label>
                                    </td>
                                    <td style="font-weight: normal; height: 20px; color: #000; width: 20%;" align="left">
                                        <asp:TextBox ID="txtVisitSampleNo" ToolTip="Lab Bill No / Visit No" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="Numbers" TargetControlID="txtVisitSampleNo"
                                            runat="server">
                                        </ajc:FilteredTextBoxExtender>
                                    </td>
                                    <td style="font-weight: normal; height: 20px; color: #000;" align="center">
                                        Select year
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSearchYear" ToolTip="Year" CssClass="ddlsmall">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10%;" align="left">
                                        <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table width="100%" id="tblPayments" visible="false" runat="server" border="0" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td>
                                    This Bill has pending payments kindly make payment to view report
                                    <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnPayNow_Click" onmouseout="this.className='btn'" />
                                </td>
                            </tr>
                        </table>
                        <asp:Label runat="server" ID="lblStatus" Visible="false" Text="No Matching Record Found"></asp:Label>
                        <asp:DataList ID="grdResult" runat="server" CellPadding="4" RepeatLayout="Table"
                            ForeColor="#333333" OnItemDataBound="grdResult_ItemDataBound" ItemStyle-VerticalAlign="Top"
                            RepeatDirection="Horizontal" OnItemCommand="grdResult_ItemCommand">
                            <ItemTemplate>
                                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                    cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top">
                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td style="height: 20px;" class="Duecolor">
                                                        Report
                                                        <asp:Label runat="server" ID="lblReportID" Visible="false" Text='<%#Eval("TemplateID") %>'>
                                                        </asp:Label>
                                                        <asp:Label runat="server" ID="lblReportname" Visible="false" Text='<%#Eval("ReportTemplateName") %>'>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td style="font-weight: normal;">
                                                        <asp:DataList ID="dlChildInvName" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table"
                                                            runat="server" OnItemCommand="dlChildInvName_ItemCommand" ItemStyle-VerticalAlign="Top"
                                                            Width="100%">
                                                            <ItemTemplate>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="lblInvname" Text='<%#Eval("InvestigationName") %>'>
                                                                            </asp:Label>
                                                                            <asp:Label runat="server" Visible="false" ID="lblInvID" Text='<%#Eval("InvestigationID") %>'>
                                                                            </asp:Label>
                                                                            <asp:Label runat="server" ID="lblReportID" Visible="false" Text='<%#Eval("TemplateID") %>'>
                                                                            </asp:Label>
                                                                            <asp:Label runat="server" ID="lblReportname" Visible="false" Text='<%#Eval("ReportTemplateName") %>'>
                                                                            </asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="true" Font-Underline="true"
                                                                                runat="server" Visible="false" Text="Show" CommandName="ShowReport">
                                                                            </asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="color: #000000; height: 20px;" align="center">
                                                        <asp:LinkButton ID="lnkShowReport" ForeColor="Black" runat="server" Text="ShowReport"
                                                            CommandName="ShowReport" Font-Underline="true"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <rsweb:ReportViewer ID="ReportViewer" runat="server" ProcessingMode="Remote">
                            <ServerReport ReportServerUrl="" />
                        </rsweb:ReportViewer>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
