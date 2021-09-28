<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditReferringDoctor.aspx.cs"
    Inherits="Billing_EditReferringDoctor" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../Scripts/Common.js"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
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
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblText" 
                                        Text="Enter Billed Item Name To Search :" meta:resourcekey="lblTextResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtItemnae" runat="server" 
                                        meta:resourcekey="txtItemnaeResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:Button ID="btnSearch" runat="server" Text="Search" />--%>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnSearch_Click" 
                                        meta:resourcekey="btnSearchResource1" />
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Label runat="server" Font-Bold="True" ForeColor="Red" ID="lblStatus" 
                                        meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblBillDeatils" Font-Bold="True" Font-Size="Medium" Visible="False"
                                        runat="server" Text="Paid Bill Details" 
                                        meta:resourcekey="lblBillDeatilsResource1"></asp:Label>
                                </td>
                                <td align="center">
                                    <asp:Label ID="lblDueDetails" Font-Bold="True" Font-Size="Medium" Visible="False"
                                        runat="server" Text="Due Bill Items" 
                                        meta:resourcekey="lblDueDetailsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:GridView DataKeyNames="BillingDetailsID" Visible="False" ID="grdBillingdetails"
                                        runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                        Width="98%" OnRowCommand="grdBillingdetails_RowCommand" OnRowDataBound="grdBillingdetails_RowDataBound"
                                        ForeColor="#333333" CssClass="mytable1" ItemStyle-VerticalAlign="Top" 
                                        RepeatDirection="Horizontal" 
                                        OnPageIndexChanging="grdBillingdetails_PageIndexChanging" 
                                        meta:resourcekey="grdBillingdetailsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField DataField="FeeDescription" HeaderText="Item Name" 
                                                meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                HeaderText="DateTime" meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField DataField="FeeType" HeaderText="Type" 
                                                meta:resourcekey="BoundFieldResource3" />
                                            <asp:TemplateField HeaderText="Referring Physician" 
                                                meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlRefnameBD" runat="server" 
                                                        meta:resourcekey="ddlRefnameBDResource1">
                                                    
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action" 
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkUpdate" CommandName="BDUpdate" CommandArgument='<%# DataBinder.Eval(Container,"RowIndex") %>'
                                                        Text="Update" runat="server" meta:resourcekey="lnkUpdateResource1"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <%--</tr>
                            <tr>--%>
                                <%--  </tr>
                            <tr>--%>
                                <td align="center" valign="top">
                                    <asp:GridView DataKeyNames="DetailsID" Visible="False" ID="grdDueChart" runat="server"
                                        OnRowCommand="grdDueChart_RowCommand" OnRowDataBound="grdDueChart_RowDataBound"
                                        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False" Width="98%" ForeColor="#333333"
                                        CssClass="mytable1" ItemStyle-VerticalAlign="Top" 
                                        RepeatDirection="Horizontal" 
                                        OnPageIndexChanging="grdDueChart_PageIndexChanging" 
                                        meta:resourcekey="grdDueChartResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField DataField="Description" HeaderText="Item Name" 
                                                meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField DataField="CreatedAt" HeaderText="DateTime" 
                                                meta:resourcekey="BoundFieldResource5" />
                                            <asp:BoundField DataField="FeeType" HeaderText="Type" 
                                                meta:resourcekey="BoundFieldResource6" />
                                            <asp:TemplateField HeaderText="Referring Physician" 
                                                meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlDCRefname" runat="server" 
                                                        meta:resourcekey="ddlDCRefnameResource1">
                                                    
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action" 
                                                meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDCUpdate" CommandName="DueChartUpdate" CommandArgument='<%# DataBinder.Eval(Container,"RowIndex") %>'
                                                        Text="Update" runat="server" meta:resourcekey="lnkDCUpdateResource1"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
