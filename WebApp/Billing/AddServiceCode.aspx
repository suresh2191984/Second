<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddServiceCode.aspx.cs" Inherits="Billing_AddServiceCode"
    meta:resourcekey="PageResource1" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Service Code</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
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
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grdRefund" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                        DataKeyNames="BillingDetailsID" ForeColor="#333333" CssClass="mytable1" runat="server"
                                                        meta:resourcekey="grdRefundResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:TemplateField Visible="False" HeaderText="Bill No" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBillDetailsID" runat="server" Text='<%# Bind("BillingDetailsID") %>'
                                                                        meta:resourcekey="lblBillDetailsIDResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bill No" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFinalBillID" runat="server" Text='<%# Bind("BillNumber") %>' meta:resourcekey="lblFinalBillIDResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="3%" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="FeeType" Visible="False" HeaderText="Fee Type" meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("FeeDescription") %>'
                                                                        meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" Width="30%" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="FORENAME" HeaderText="Received By" meta:resourcekey="BoundFieldResource2">
                                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Billed Amt" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount") %>' meta:resourcekey="lblAmountResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="ServiceCode" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtServiceCode" Text='<%# Bind("ServiceCode") %>' runat="server"
                                                                        meta:resourcekey="txtServiceCodeResource1"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Display Text">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtDisplayText" Text='<%# Bind("AttributeDetail") %>' runat="server"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="5%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="Tr1" runat="server">
                                                <td id="Td1" align="center" runat="server">
                                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                        OnClick="btnSave_Click" Width="68px" />
                                                    &nbsp;<asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" onmouseout="this.className='btn1'"
                                                        Width="71px" OnClick="btnCancel_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblResult" Visible="False" runat="server" CssClass="label_error" meta:resourcekey="lblResultResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr align="center" valign="middle">
                                                <td align="center" valign="middle">
                                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                                        <ProgressTemplate>
                                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                            <asp:Label ID="lblpleasewait" runat="server" Text="Please wait...." meta:resourcekey="Label1Resource1"></asp:Label>
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
