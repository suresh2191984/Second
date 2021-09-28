<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoicePayment.aspx.cs" Inherits="Ledger_InvoicePayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>

<%-- <%@ Register Src="../CommonControls/TSPClientCurrentLedgerStatus.ascx" TagName="TSPLedger"
    TagPrefix="uc3" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Client OutStanding Invoice Payment</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
         
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
        .button-link
        {
            background-color: transparent;
            border: none;
        }
        .button-link:hover
        {
            color: blue;
            text-decoration: underline;
        }
        table.dataTable tbody tr.selected
        {
            background-color: #B0BED9;
        }
        table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover
        {
            background-color: #FFFF77;
        }
        .FixedHeader
        {
            position: absolute;
            font-weight: bold;
        }
        /*test*/body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .Grid td
        {
            background-color: #CED8F6;
            color: black;
            font-size: 10pt;
            line-height: 200%;
        }
        .Grid th
        {
            background-color: #5D86A0;
            color: F4FFFF;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGrid td
        {
            background-color: #eee !important;
            color: black;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGrid th
        {
            background-color: #6C6C6C !important;
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGridLeaf td
        {
            background-color: #F2F5A9 !important;
            emptydatarowstyle-backcolor: == "Yellow" color:black;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGridLeaf th
        {
            background-color: #0B615E !important;
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .gridview
        {
            background-color: #fff;
            padding: 2px;
            margin: 2% auto;
        }
        .gridview a
        {
            margin: auto 1%;
            background-color: #446D87;
            padding: 5px 10px 5px 10px;
            color: #fff;
            text-decoration: none;
            -o-box-shadow: 1px 1px 1px #111;
            -moz-box-shadow: 1px 1px 1px #111;
            -webkit-box-shadow: 1px 1px 1px #111;
            box-shadow: 1px 1px 1px #111;
        }
        .gridview span
        {
            background-color: #007D9E;
            color: #fff;
            -o-box-shadow: 1px 1px 1px #111;
            -moz-box-shadow: 1px 1px 1px #111;
            -webkit-box-shadow: 1px 1px 1px #111;
            box-shadow: 1px 1px 1px #111;
            padding: 5px 10px 5px 10px;
        }
    </style>
    <%--<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />--%>
   <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet"
        type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" style="text-align: center">
        <asp:UpdatePanel ID="UdtPanel" runat="server">
            <ContentTemplate>
                <table width="100%" class="searchPanel">
                    <tr>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 80%">
                            <div class="a-center w-90p" id="DivLpwd" runat="server">
                                <table class="w-100p a-center">
                                    <tr>
                                        <td class="w-100p bold a-center padding5 header-color">
                                            INVOICE LEDGER PAYMENT
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td width="5%">
                        </td>
                        <td width="40%" align="left" style="font-weight: bold;">
                        </td>
                        <td id="tdFilterGrid" align="right" runat="server" width="45%" style="display: none">
                            <asp:Label ID="lblfilter" runat="server" Font-Bold="true" Text="Filter"></asp:Label>
                            <asp:TextBox ID="txtfilter" onkeyup="Search_Gridview(this, 'grdOutstanding')" CssClass="medium"
                                runat="server"></asp:TextBox>
                        </td>
                        <td width="5%" id="tblhome" runat="server" style="display: none">
                            <asp:Button ID="btnhome" CssClass="btn" runat="server" Text="Home" ToolTip="Go to Home" OnClick="btnhome_Click" />
                        </td>
                        <td width="5%">
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td width="5%">
                        </td>
                        <td width="90%">
                            <div id="masterdata" runat="server" style="width: 100%;" align="center">
                                <asp:GridView ID="grdOutstanding" runat="server" AutoGenerateColumns="False" CssClass="gridView a-center"
                                    DataKeyNames="ClientId" meta:resourceKey="grdResultResource1" AllowPaging="True"
                                    PagerStyle-CssClass="gridview" OnPageIndexChanging="grdOutstanding_PageIndexChanging"
                                    Width="100%">
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="5" PreviousPageText="" />
                                    <PagerStyle HorizontalAlign="right" ForeColor="White" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" HeaderStyle-VerticalAlign="Middle"
                                            meta:resourceKey="BoundFieldResource2" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="30%"
                                            ItemStyle-Width="30%"></asp:BoundField>
                                        <asp:BoundField DataField="Address"  HeaderText="Address"
                                            meta:resourceKey="BoundFieldResource3" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="30%"
                                            ItemStyle-Width="30%"></asp:BoundField>
                                        <asp:BoundField DataField="Total"  HeaderText="Total Pending Invoice"
                                            HeaderStyle-Width="20%" ItemStyle-Width="20%" ItemStyle-HorizontalAlign="right">
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkpay" Font-Bold="true" Width="5%" runat="server" OnClick="lnkpay_Click"
                                                    Text="Pay"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                        <td width="5%">
                        </td>
                    </tr>
                </table>
                <table class="w-100p" border="0">
                    <tr>
                        <td class="w-5p">
                        </td>
                        <td class="w-90p" align="center">
                            <asp:GridView ID="GrdLedgerClient" runat="server" CssClass="Grid" AutoGenerateColumns="false"
                                DataKeyNames="ClientId" GridLines="None" Width="100%" BorderStyle="Solid" BorderWidth="1px"
                                BorderColor="Navy" EmptyDataText="No Records Found" EmptyDataRowStyle-BackColor="Yellow"
                                OnRowDataBound="GrdLedgerClient_OnRowDataBound" SelectedIndex="1" OnPageIndexChanging="GrdLedgerClient_PageIndexChanging"
                                PageSize="10" AllowPaging="True" OnSelectedIndexChanged="GrdLedgerClient_SelectedIndexChanged">
                                <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
                                <RowStyle BackColor="#E1E1E1" />
                                <AlternatingRowStyle BackColor="red" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <a href="JavaScript:divexpandcollapse('div<%# Eval("ClientId") %>');">
                                                <img id="imgdiv<%# Eval("ClientId") %>" width="12px" border="0" src="../Images/plus.gif"
                                                    alt="" /><p style="display: none;">
                                                        div</p>
                                            </a>
                                            <%--<asp:ImageButton ID="imgbtn1" CommandArgument='<%# Eval("ClientId") %>' runat="server"  CommandName="Expend" ImageUrl="../Images/plus.gif" />--%>
                                        </ItemTemplate>
                                        <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" Width="50px"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Client ID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblClientID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ClientId") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ClientName" HeaderText="Client Name" ItemStyle-HorizontalAlign="Justify"
                                        ItemStyle-VerticalAlign="Middle" />
                                    <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-HorizontalAlign="Justify"
                                        ItemStyle-VerticalAlign="Middle" />
                                    <asp:BoundField DataField="Total" HeaderText="Total Invoice" ItemStyle-HorizontalAlign="Right"
                                        ItemStyle-VerticalAlign="Middle" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <tr>
                                                <td width="20px">
                                                </td>
                                                <td colspan="100%">
                                                    <div id="div<%# Eval("ClientId") %>" style="overflow: auto; display: none; position: relative;">
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="95%">
                                                                    <asp:GridView ID="GrdLedgerInvoice" runat="server" AutoGenerateColumns="false" DataKeyNames="InvoiceId"
                                                                        OnRowDataBound="GrdLedgerInvoice_OnRowDataBound" BorderStyle="Solid" BorderWidth="1px"
                                                                        CssClass="ChildGrid" BorderColor="#df5015" GridLines="None" Width="100%" EmptyDataText="No Records Found"
                                                                        EmptyDataRowStyle-BackColor="Yellow">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <a href="JavaScript:divexpandcollapse('divA<%# Eval("InvoiceId") %>');">
                                                                                        <img id="imgdivA<%# Eval("InvoiceId") %>" width="12px" border="0" src="../Images/plus.gif"
                                                                                            alt="" /><p style="display: none;">
                                                                                                div1</p>
                                                                                    </a>
                                                                                </ItemTemplate>
                                                                                <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Invoice ID" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInvoiceID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InvoiceId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <input type="checkbox" id="chkMultipleCheck" runat="server" checked="false" onclick="javascript:return checkedMultipleSelect(this.id);"></checkbox>
                                                                                    <asp:HiddenField runat="server" ID="hdnDivImgID" Value='<%# Eval("InvoiceId") %>' />
                                                                                    <asp:HiddenField runat="server" ID="hdnClientIDMultiplePay" Value='<%# Eval("ClientId") %>' />
                                                                                    <asp:HiddenField ID="hdnMultipleClientCode" runat="server" Value='<%# Eval("ClientCode") %>' />
                                                                                    <asp:HiddenField ID="hdnMultipleCurrencyCode" runat="server" Value='<%# Eval("CurrencyCode") %>' />
                                                                                    <asp:HiddenField ID="hdnCheckStatus" runat="server" Value='<%# Eval("Total") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1%>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice Number" ItemStyle-HorizontalAlign="Center" />
                                                                            <asp:BoundField DataField="FromDate" HeaderText="Invoice From" ItemStyle-HorizontalAlign="Center" />
                                                                            <asp:BoundField DataField="ToDate" HeaderText="Invoice To" ItemStyle-HorizontalAlign="Center" />
                                                                            <%--<asp:BoundField DataField="Amount" ItemStyle-BackColor="Green" ItemStyle-HorizontalAlign="Right" HeaderText="Invoice Amount" />--%>
                                                                            <asp:TemplateField HeaderText="Invoice Amount" ItemStyle-BackColor="Red" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInvAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Amount") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="ReceivedAmt" HeaderText="Received Amount" />
                                                                            <asp:TemplateField HeaderText="Discount" ItemStyle-BackColor="Red" ItemStyle-HorizontalAlign="center">
                                                                                <ItemTemplate>
                                                                                    <asp:DropDownList ID="ddlDiscount" runat="server" Enabled="false" onchange="javascript:return SelectedDiscount(this.id);">
                                                                                        <asp:ListItem Value="0" Text="0%" Selected="True"></asp:ListItem>
                                                                                        <asp:ListItem Value="5" Text="5%"></asp:ListItem>
                                                                                        <asp:ListItem Value="10" Text="10%"></asp:ListItem>
                                                                                        <asp:ListItem Value="15" Text="15%"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Discount Amount" ItemStyle-BackColor="Red" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDisAmount" runat="server" Text="0.00"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Net Amount" ItemStyle-BackColor="Red" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "NetValue") %>'></asp:Label>
                                                                                    <asp:HiddenField ID="hdnMultipleInvoiceID" runat="server" Value='<%# Eval("InvoiceId") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <tr>
                                                                                        <td width="20px">
                                                                                        </td>
                                                                                        <td colspan="100%">
                                                                                            <div id="divA<%# Eval("InvoiceId") %>" style="overflow: auto; background-color: Green;
                                                                                                display: none; position: relative;">
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td style="font-size: larger; font-family: Raavi; font-weight: bold; color: Navy">
                                                                                                            Bill Details
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%">
                                                                                                            <asp:GridView ID="GrdLedgerInvoiceBills" CssClass="ChildGridLeaf" runat="server"
                                                                                                                AutoGenerateColumns="false" DataKeyNames="BillId" BorderStyle="Solid" BorderWidth="1px"
                                                                                                                BorderColor="#df5015" GridLines="None" OnRowDataBound="GrdLedgerInvoiceBills_RowDataBound"
                                                                                                                Width="100%" EmptyDataText="No Records Found" EmptyDataRowStyle-BackColor="Yellow">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                                                                        <ItemTemplate>
                                                                                                                            <%# Container.DataItemIndex+1%>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField>
                                                                                                                        <ItemTemplate>
                                                                                                                            <input type="checkbox" id="chkbillid" runat="server" checked="true" onclick="javascript:return checkedValues(this.id);"></checkbox>
                                                                                                                            <asp:HiddenField ID="hdnBillId" runat="server" Value='<%# Eval("BillId") %>' />
                                                                                                                            <asp:HiddenField ID="hdnClientID" runat="server" Value='<%# Eval("ClientID") %>' />
                                                                                                                            <asp:HiddenField ID="hdnInvoiceID" runat="server" Value='<%# Eval("InvoiceId") %>' />
                                                                                                                            <asp:HiddenField ID="hdnClientCode" runat="server" Value='<%# Eval("ClientCode") %>' />
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="Name" HeaderText="Patient Name" />
                                                                                                                    <asp:BoundField DataField="FromDate" HeaderText="Bill Date" />
                                                                                                                    <asp:BoundField DataField="Barcode" HeaderText="Barcodes" />
                                                                                                                    <%--<asp:BoundField DataField="Test" HeaderText="Tests" />--%>
                                                                                                                    <asp:TemplateField HeaderText="Tests" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblLabelWithToolTip" runat="server" Text='<%#Eval("Test") %>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblBillAmount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Amount") %>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right" style="color: #0B615E; font-weight: bold;">
                                                                                                            Total Bill Amount =
                                                                                                            <asp:Label ID="lblBillSummary" runat="server" Font-Bold="true" ForeColor="#0B615E"
                                                                                                                Text=""></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td style="font-size: larger; font-family: Raavi; font-weight: bold; color: Red">
                                                                                                            Debit Details
                                                                                                        </td>
                                                                                                        <%--<td align="right" style="font-size: larger; font-family: Raavi; font-weight: bold;
                                                                                                            color: Red">
                                                                                                            (+)
                                                                                                        </td>--%>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%">
                                                                                                            <asp:GridView ID="GrdLedgerInvoiceDebits" CssClass="ChildGridLeaf" runat="server"
                                                                                                                AutoGenerateColumns="false" DataKeyNames="DebitID" BorderStyle="Solid" BorderWidth="1px"
                                                                                                                BorderColor="#df5015" GridLines="None" Width="100%" EmptyDataText="No Records Found"
                                                                                                                EmptyDataRowStyle-BackColor="Yellow">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <%# Container.DataItemIndex+1%>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="ClientCode" HeaderText="Client" />
                                                                                                                    <asp:BoundField DataField="Narration" HeaderText="Narration" />
                                                                                                                    <asp:BoundField DataField="FromDate" HeaderText="Debit Raised On" />
                                                                                                                    <asp:BoundField DataField="ToDate" HeaderText="Debit Approved On" />
                                                                                                                    <asp:BoundField DataField="NetValue" HeaderText="Net Debit" />
                                                                                                                    <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Amount" HeaderText="Available Debit" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right" style="color: #0B615E; font-weight: bold;">
                                                                                                            Total Debit Amount =
                                                                                                            <asp:Label ID="lblDebitSummary" runat="server" Font-Bold="true" ForeColor="#0B615E"
                                                                                                                Text=""></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td style="font-size: larger; font-family: Raavi; font-weight: bold; color: Green">
                                                                                                            Credit Details
                                                                                                        </td>
                                                                                                        <%--<td align="right" style="font-size: larger; font-family: Raavi; font-weight: bold;
                                                                                                            color: Red">
                                                                                                            (-)
                                                                                                        </td>--%>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%">
                                                                                                            <asp:GridView ID="GrdLedgerInvoiceCredits" CssClass="ChildGridLeaf" runat="server"
                                                                                                                AutoGenerateColumns="false" DataKeyNames="CreditID" BorderStyle="Solid" BorderWidth="1px"
                                                                                                                BorderColor="#df5015" GridLines="None" Width="100%" EmptyDataText="No Records Found"
                                                                                                                EmptyDataRowStyle-BackColor="Yellow">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <%# Container.DataItemIndex+1%>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="ClientCode" HeaderText="Client" />
                                                                                                                    <asp:BoundField DataField="Narration" HeaderText="Narration" />
                                                                                                                    <asp:BoundField DataField="FromDate" HeaderText="Credit Raised On" />
                                                                                                                    <asp:BoundField DataField="ToDate" HeaderText="Credit Approved On" />
                                                                                                                    <asp:BoundField DataField="NetValue" HeaderText="Net Credit" />
                                                                                                                    <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Amount" HeaderText="Available Credit" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right" style="color: #0B615E; font-weight: bold;">
                                                                                                            Total Credit Amount =
                                                                                                            <asp:Label ID="lblCreditSummary" runat="server" Font-Bold="true" ForeColor="#0B615E"
                                                                                                                Text=""></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right" style="color: Navy; font-weight: bold;">
                                                                                                            Net Amount = ( Total Bills + Total Debits ) - Total Credits
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right" style="color: Navy; font-weight: bold;">
                                                                                                            <asp:Label ID="lblSumlBill" runat="server" Font-Bold="true" ForeColor="Navy" Text=""></asp:Label> +
                                                                                                            <asp:Label ID="lblSumDebit" runat="server" Font-Bold="true" ForeColor="Navy" Text=""></asp:Label> - 
                                                                                                            <asp:Label ID="lblSumCredit" runat="server" Font-Bold="true" ForeColor="Navy" Text=""></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right">
                                                                                                            <asp:Label ID="lblTotal" ForeColor="Red" runat="server" Font-Bold="true" Text="Total"
                                                                                                                Payable=""></asp:Label>
                                                                                                            <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true" ForeColor="Red" Text=""></asp:Label>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <table width="100%" id="tblSinglePayLink">
                                                                                                    <tr>
                                                                                                        <td width="95%" align="right">
                                                                                                            <asp:ImageButton ID="lnkPayAmountOffline" Width="100px" ToolTip="Pay through Offline"
                                                                                                                OnClientClick="javascript:selectClient(this.id,'OFFLINE')" runat="server" ImageUrl="~/Images/Pay-Offline.png" />
                                                                                                            <%--<asp:LinkButton ID="lnkPayAmountOffline" CssClass="btn" Width="150px" Font-Underline="true" 
                                                                                                                Font-Bold="true" Font-Names="Raavi" Font-Size="Large" runat="server" Text="Pay Offline"
                                                                                                                OnClientClick="javascript:selectClient(this.id,'OFFLINE')"></asp:LinkButton>--%>
                                                                                                            <asp:ImageButton ID="lnkPayAmount" Width="100px" ToolTip="Pay through Online" OnClientClick="javascript:selectClient(this.id,'ONLINE')"
                                                                                                                runat="server" ImageUrl="~/Images/Pay-Online.png" />
                                                                                                            <%--<asp:LinkButton ID="lnkPayAmount" CssClass="btn" Width="50px" Font-Underline="true"
                                                                                                                Font-Bold="true" Font-Names="Raavi" Font-Size="Large" runat="server" Text="Pay"
                                                                                                                OnClientClick="javascript:selectClient(this.id,'ONLINE')"></asp:LinkButton>--%>
                                                                                                        </td>
                                                                                                        <td width="5%">
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                                <td width="5%">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="95%" align="right" style="color: #0B615E; font-weight: bold;">
                                                                    Total Invoice Amount =
                                                                    <asp:Label ID="lblMultipleAmount" runat="server" Font-Bold="true" ForeColor="#0B615E"
                                                                        Text="0.000"></asp:Label>
                                                                </td>
                                                                <td width="5%">
                                                                </td>
                                                                <tr>
                                                                    <td width="95%" align="right">
                                                                        <asp:ImageButton ID="lnkMultiplePayAmountOffline" Width="100px" ToolTip="Pay through Offline"
                                                                            OnClientClick="javascript:return selectInvoiceForMultiple(this.id,'MULTIPLEOFFLINE')"
                                                                            runat="server" ImageUrl="~/Images/Pay-Offline.png" />
                                                                        <asp:ImageButton ID="lnkMultiplePayAmountOnline" Width="100px" ToolTip="Pay through Online"
                                                                            OnClientClick="javascript:return selectInvoiceForMultiple(this.id,'MULTIPLEONLINE')"
                                                                            runat="server" ImageUrl="~/Images/Pay-Online.png" />
                                                                    </td>
                                                                </tr>
                                                            </tr>
                                                        </table>
                                                    </div>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#0063A6" ForeColor="White" />
                            </asp:GridView>
                        </td>
                        <td class="w-5p">
                        </td>
                    </tr>
                </table>
                   </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnclientType" runat="server" />
    <asp:HiddenField ID="hdnCID" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    function divexpandcollapse(divname) {
        var div = document.getElementById(divname);
        var img = document.getElementById('img' + divname);
        if (div.style.display == "none") {
            div.style.display = "inline";
            img.src = "../Images/minus.gif";
        }
        else {
            div.style.display = "none";
            img.src = "../Images/plus.gif";
        }
    }
    function divexpandcollapseStatus(divname) {
        var div = document.getElementById(divname);
        var img = document.getElementById('img' + divname);
        if (div.style.display == "none") {
            div.style.display = "inline";
            img.src = "../Images/minus.gif";
        }
        else {
            div.style.display = "none";
            img.src = "../Images/plus.gif";
        }
    }
    function checkedValues(Id) {
        var CheckAmount = document.getElementById(Id);
        var lstPayableAmount = Id.split("_");
        var ConPayableAmount = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_" + lstPayableAmount[2] + "_" + lstPayableAmount[3] + "_lblTotalAmount";
        var BillSummary = ConPayableAmount.replace("lblTotalAmount", "lblBillSummary");
        var BillFinalSummary = ConPayableAmount.replace("lblTotalAmount", "lblSumlBill");

        var PayableAmount = document.getElementById(ConPayableAmount);
        var PayableAmountVal = PayableAmount.innerHTML;

        if (CheckAmount.checked) {
            var lblBillAmount = document.getElementById(Id.replace("chkbillid", "lblBillAmount"));
            var BillAmount = parseFloat(lblBillAmount.innerHTML);
            var GrdTotalBill = document.getElementById(BillSummary).innerHTML;
            var GrdCalcBillValue = parseFloat(parseFloat(GrdTotalBill) + parseFloat(BillAmount)).toFixed(3);
            var CalculatedValue = parseFloat(parseFloat(PayableAmountVal) + parseFloat(BillAmount)).toFixed(3);
        }
        else {
            var lblBillAmount = document.getElementById(Id.replace("chkbillid", "lblBillAmount"));
            var BillAmount = parseFloat(lblBillAmount.innerHTML);
            var GrdTotalBill = document.getElementById(BillSummary).innerHTML;
            var GrdCalcBillValue = parseFloat(parseFloat(GrdTotalBill) - parseFloat(BillAmount)).toFixed(3);
            var CalculatedValue = parseFloat(parseFloat(PayableAmountVal) - parseFloat(BillAmount)).toFixed(3);
        }
        document.getElementById(BillSummary).innerHTML = GrdCalcBillValue;
        document.getElementById(BillFinalSummary).innerHTML = GrdCalcBillValue;
        document.getElementById(ConPayableAmount).innerHTML = CalculatedValue;
    }

    function Search_Gridview(strKey, strGV) {
        var strData = strKey.value.toLowerCase().split(" ");
        var tblData = document.getElementById(strGV);
        var rowData;
        for (var i = 1; i < tblData.rows.length; i++) {
            rowData = tblData.rows[i].innerHTML;
            var styleDisplay = 'none';
            for (var j = 0; j < strData.length; j++) {
                if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                    styleDisplay = '';
                else {
                    styleDisplay = 'none';
                    break;
                }
            }
            tblData.rows[i].style.display = styleDisplay;
        }
    }

    function selectClient(id, val) {
        var counter = 0;
        debugger;
        var CheckAmount = document.getElementById(id);
        var lstPayableAmount = id.split("_");
        var conId = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_" + lstPayableAmount[2] + "_" + lstPayableAmount[3] + "_GrdLedgerInvoiceBills";
        var ChkBoxId = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_" + lstPayableAmount[2] + "_" + lstPayableAmount[3] + "_GrdLedgerInvoiceBills_";
        var rowscount = 0;
        var IdArray = '';
        var i = 0;
        var BillCheck = '';
        var SelectFlag = 0;
        var InvoiceDetailsID = '';
        var ClientID = '';
        var InvoiceID = '';
        var GridId = '';
        var clientcode = '';
        var Amount = '';
        var mode = '';
        var PaymentType = '';
        var orgid = document.getElementById('hdnOrgID').value;
        rowscount = (document.getElementById(conId).rows.length);
        debugger;
        for (i = 2; i <= rowscount; i++) {
            debugger;
            var a = '';
            if (i < 10) {
                a = 'ctl0' + i;
            }
            if (i > 9) {
                a = 'ctl' + i;
            }
            BillCheck = ChkBoxId + a + '_chkbillid';

            if (document.getElementById(BillCheck).checked == true) {
                SelectFlag = 1;
                IdArray = IdArray + (document.getElementById(ChkBoxId + a + '_hdnBillId').value) + '^';
                ClientID = document.getElementById(ChkBoxId + a + '_hdnClientID').value;
                InvoiceID = document.getElementById(ChkBoxId + a + '_hdnInvoiceID').value;
                // clientcode = document.getElementById(ChkBoxId + a + '_hdnClientCode').value;
            }
        }
        if (SelectFlag == 0) {
            alert('Please Select any one Bill..!');
            return false;

        }
        else {
            if (val == 'OFFLINE') {
                GridId = id.replace('lnkPayAmountOffline', 'lblTotalAmount');
                PaymentType = 'BILLWISE';
            }
            else if (val == 'ONLINE') {
                GridId = id.replace('lnkPayAmount', 'lblTotalAmount');
                PaymentType = 'BILLWISE';
            }

            Amount = document.getElementById(GridId).innerHTML || document.getElementById(GridId).textContent;
            if (Amount < 0) {
                alert('Payable Amount Should be Greater than Zero!');
                return false;
            }
            InvoiceDetailsID = IdArray.substring(0, IdArray.length - 1);

            try {
                if (ClientID != '' && InvoiceID != '' && InvoiceDetailsID != '' && Amount != '') {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/CreateClientOutstandingOnlineOfflinePayLinkSession",
                        contentType: "application/json;charset=utf-8",
                        data: "{'Amount':'" + Amount + "','ClientID':'" + ClientID + "','InvoiceID':'" + InvoiceID + "','InvoiceDetailsID':'" + InvoiceDetailsID + "','mode':'" + val + "','PaymentType':'" + PaymentType + "','orgid':'" + orgid + "'}",
                        dataType: "json",
                        async: false,
                        success: AjaxGetPaySessionCreation,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            // $('#example').hide();
                            return false;
                        }
                    });
                    $('#example').show();
                }
            }
            catch (e) {
                alert('Exception while Creation of Payment Session');
            }
            return false;
        }
    }
    function AjaxGetPaySessionCreation(result) {
        try {
            if (result.d == "ONLINE") {
                var orgid = '';
                orgid = document.getElementById('hdnOrgID').value;
                if (orgid == "75") {
                    //window.open("../Payment/Payment.aspx");
                    //   window.location.href = "../Payment/Payment.aspx";
                    return true;
                }
                else if (orgid == "77" || orgid == "80" || orgid == "159" || orgid == "161" || orgid == "162") {
                    //window.open("../Payment/CrediMaxPayment.aspx");
                    window.location.href = "../Payment/CrediMaxPayment.aspx";
                    return true;
                }
            }
            if (result.d == "OFFLINE") {
                var orgid = '';
                orgid = document.getElementById('hdnOrgID').value;
                if (orgid == "70") {

                    //   window.location.href = "../Ledger/ClientCreditDebit.aspx";
                    return true;
                }
                else if  (orgid == "77" || orgid=="80" || orgid=="159" || orgid=="161" || orgid=="162") {

                    window.location.href = "InvoiceReceiptOfflinePayment.aspx";
                    return true;
                }
            }
        }
        catch (e) {
            alert('Exception while Creation of Payment Session data');
        }
    }

    function checkedMultipleSelect(id) {
        debugger;
        var CheckAmount = document.getElementById(id);
        var lstPayableAmount = id.split("_");
        var ConPayableAmount = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_";
        var hdnID = id.replace('chkMultipleCheck', 'hdnDivImgID');
        var hdnVal = document.getElementById(hdnID).value;
        var a = document.getElementById('divA' + hdnVal);
        //image Id
        var img = document.getElementById('imgdivA' + hdnVal);
        // Total Amoumt
        var SumAmount = 0
        var AmountIdText = id.replace('chkMultipleCheck', 'lblAmount');
        var CheckedAmount = 0;
        CheckedAmount = document.getElementById(AmountIdText).innerHTML;
        var TotalAmountId = document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML;
        var IsPaidId = id.replace('chkMultipleCheck', 'hdnCheckStatus');
        var IdPaidStatus = document.getElementById(IsPaidId).value;
        if (IdPaidStatus == 1) {
            alert('Already Paid Few Bills Amount From This Invoice.So Please Verify and Procced with Bill wise payment for This..!');
            document.getElementById(id).checked = false;
            return false;

        }
        else {
            var PrevAmount = 0;
            var TotalDisplayAmount = 0;
            var InvoiceID = id.replace('chkMultipleCheck', 'lblInvoiceID');
            var orgid = document.getElementById('hdnOrgID').value;
            var ddl = id.replace('chkMultipleCheck', 'ddlDiscount');

            var AmountIdText = id.replace('ddlDiscount', 'lblAmount');
            var InvAmountIdText = id.replace('ddlDiscount', 'lblInvAmount');
            var InvDisAmountIdText = id.replace('ddlDiscount', 'lblDisAmount');
            document.getElementById(InvDisAmountIdText).innerHTML = "0.00";
            var ResetAmount = document.getElementById(InvAmountIdText).innerHTML;
            document.getElementById(InvDisAmountIdText).innerHTML = parseFloat(ResetAmount).toFixed(3);
            if (document.getElementById(id).checked == true) {
                PrevAmount = TotalAmountId;
                SumAmount = parseFloat(parseFloat(PrevAmount) + parseFloat(CheckedAmount));
                document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML = SumAmount.toFixed(3);
                img.style.display = "none";
                a.style.display = "none";
                var clientid=0;
                clientid = document.getElementById('hdnCID').value;
                if (clientid > 0) {
                    $('#' + ddl).attr('disabled', true)
                }
                else {
                    $('#' + ddl).attr('disabled', false)
                }
                $('#' + ddl).val(0);
                var range = document.getElementById(ddl);
                range.onchange({ target: range });

            }
            if (document.getElementById(id).checked == false) {

                PrevAmount = TotalAmountId;
                SumAmount = parseFloat(parseFloat(PrevAmount) - parseFloat(CheckedAmount));
                //TotalDisplayAmount = parseFloat(PrevAmount) + parseFloat();
                document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML = SumAmount.toFixed(3);
                img.style.display = "block";
                img.src = "../Images/plus.gif";
                $('#' + ddl).attr('disabled', true)
                $('#' + ddl).val(0);
                var range = document.getElementById(ddl);
                range.onchange({ target: range });
            }
        }
    }
    function selectInvoiceForMultiple(id, val) {

        var CheckAmount = 0; // document.getElementById(id);
        var rowscount = 0;
        var a = '';
        var InvoiceID = '';
        var IdArray = '';
        var lstPayableAmount = id.split("_");
        var CheckBoxID = '';
        var ClientID = 0;
        var clientcode = '';
        var PayAmount = '';
        var orgid = document.getElementById('hdnOrgID').value;
        var ValidatePayableAmountID = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_";
        CheckAmount = parseFloat(document.getElementById(ValidatePayableAmountID + 'lblMultipleAmount').innerHTML);
        PayAmount = document.getElementById(ValidatePayableAmountID + 'lblMultipleAmount').innerHTML;
        if (CheckAmount <= 0) {
            alert('Please Select Atleast One Invoice to Proceed..!');
            return false;
        }
        else {
            var InvoiceGridID = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_";
            var gridIdCont = InvoiceGridID + 'GrdLedgerInvoice';
            InvoiceGrid = document.getElementById(InvoiceGridID + 'GrdLedgerInvoice');
            var rowid = '';
            var Hdnvalue = '';
            var ClientCodeId = '';
            var ClientIDText = '';
            var InvAmount = '';
            var DiscountPercentage = '';
            var DiscountAmount = '';
            var InvDiscountAmount = '';
            var mode = '';
            var PaymentType = '';
            var InvoiceList = [];
            if (val == 'MULTIPLEOFFLINE') {
                mode = 'OFFLINE';
                PaymentType = 'INVOICEWISE';
            }
            else if (val == 'MULTIPLEONLINE') {
                mode = 'ONLINE';
                PaymentType = 'INVOICEWISE';
            }
            debugger;
            $("input[id$=chkMultipleCheck]:checked").each(function() {
                rowid = $(this).attr('id');
                Hdnvalue = rowid.replace('chkMultipleCheck', 'hdnMultipleInvoiceID');
                ClientCodeId = rowid.replace('chkMultipleCheck', 'hdnMultipleClientCode');
                ClientIDText = rowid.replace('chkMultipleCheck', 'hdnClientIDMultiplePay');
                InvAmount = rowid.replace('chkMultipleCheck', 'lblInvAmount');
                DiscountPercentage = rowid.replace('chkMultipleCheck', 'ddlDiscount');
                DiscountAmount = rowid.replace('chkMultipleCheck', 'lblDisAmount');
                InvDiscountAmount = rowid.replace('chkMultipleCheck', 'lblAmount');
                var TypeId = document.getElementById(DiscountPercentage);

                InvoiceList.push({
                    InvoiceId: document.getElementById(Hdnvalue).value,
                    ClientId: document.getElementById(ClientIDText).value,
                    PaymentMode: PaymentType,
                    OrgID: orgid,
                    DiscountPercentage: TypeId.options[TypeId.selectedIndex].value,
                    DiscountAmount: document.getElementById(DiscountAmount).innerHTML,
                    ActualAmount: document.getElementById(InvAmount).innerHTML,
                    TotalAmt: document.getElementById(InvDiscountAmount).innerHTML,
                    CR: 'N'

                });

                // IdArray += (document.getElementById(Hdnvalue).value) + '^';
                // clientcode = document.getElementById(ClientCodeId).value;
                ClientID = document.getElementById(ClientIDText).value;
            });


            var FinalSelectedInvoiceId = JSON.stringify(InvoiceList);
            try {
                if (ClientID != '' && FinalSelectedInvoiceId != '' && PayAmount != '' && PaymentType != '' && mode != '') {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/CreatePayLinkSessionForMultiplePayment",
                        contentType: "application/json;charset=utf-8",
                        data: "{'Amount':'" + PayAmount + "','ClientID':'" + ClientID + "','InvoiceID':'" + FinalSelectedInvoiceId + "','mode':'" + mode + "','PaymentType':'" + PaymentType + "','orgid':'" + orgid + "'}",
                        dataType: "json",
                        async: false,
                        success: AjaxGetPaySessionForInvoicePay,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            // $('#example').hide();
                            return false;
                        }
                    });
                    $('#example').show();
                }
            }
            catch (e) {
                alert('Exception while Creation of Payment Session');
            }
            return false;
        }
    }
    function AjaxGetPaySessionForInvoicePay(result) {
        debugger;
        try {
            if (result.d == "ONLINE") {
                var orgid = '';
                orgid = document.getElementById('hdnOrgID').value;
                if (orgid == "75") {
                    //window.open("../Payment/Payment.aspx");
                    //  window.location.href = "../Payment/Payment.aspx";
                    return true;
                }
                else if (orgid == "77" || orgid == "80" || orgid == "159" || orgid == "161" || orgid == "162") {
                    //window.open("../Payment/CrediMaxPayment.aspx");
                    window.location.href = "../Payment/CrediMaxPayment.aspx";
                    return true;
                }
            }
            if (result.d == "OFFLINE") {
                var orgid = '';
                orgid = document.getElementById('hdnOrgID').value;
                if (orgid == "75") {

                    //   window.location.href = "../Ledger/ClientCreditDebit.aspx";
                    return true;
                }
                else if (orgid == "77" || orgid == "80" || orgid == "159" || orgid == "161" || orgid == "162") {
                    window.location.href = "../Ledger/InvoiceReceiptOfflinePayment.aspx";
                    return true;
                }
            }
        }
        catch (e) {
            alert('Exception while Creation of Payment Session data');
        }
    }
    function FunHome() {
        debugger;
        $('#tblhome').hide();
        window.location.replace("../Ledger/InvoicePayment.aspx");
    }
    function SelectedDiscount(Id) {
        debugger;
        var checkeddata = "";
        checkeddata = Id.replace('ddlDiscount', 'chkMultipleCheck');
        if (document.getElementById(checkeddata).checked == true) {
            var ddl = "";
            var SelectedPersantage = "";
            ddl = document.getElementById(Id);
            SelectedPersantage = ddl.options[ddl.selectedIndex].value;
            var AmountIdText = Id.replace('ddlDiscount', 'lblAmount');
            var InvAmountIdText = Id.replace('ddlDiscount', 'lblInvAmount');
            var InvDisAmountIdText = Id.replace('ddlDiscount', 'lblDisAmount');
            var CheckedAmount = 0;
            var SumAmount = 0;
            var TotalAmountId = 0;
            var lstPayableAmount = Id.split("_");
            var ConPayableAmount = lstPayableAmount[0] + "_" + lstPayableAmount[1] + "_";
            var PreviousDis = document.getElementById(InvDisAmountIdText).innerHTML;
            var PreviousTotalAmount = document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML;
            var netval = parseFloat(PreviousTotalAmount) + parseFloat(PreviousDis);
            document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML = netval.toFixed(3);

            CheckedAmount = document.getElementById(InvAmountIdText).innerHTML;
            var DiscumentAmount = (parseFloat(CheckedAmount) * parseFloat(SelectedPersantage)) / 100;
            var AfterDiscumentInvoiceAmount = parseFloat(CheckedAmount) - parseFloat(DiscumentAmount);
            document.getElementById(InvDisAmountIdText).innerHTML = DiscumentAmount.toFixed(3);
            document.getElementById(AmountIdText).innerHTML = AfterDiscumentInvoiceAmount.toFixed(3);

            TotalAmountId = document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML;
            SumAmount = parseFloat(parseFloat(TotalAmountId) - parseFloat(DiscumentAmount));
            document.getElementById(ConPayableAmount + 'lblMultipleAmount').innerHTML = SumAmount.toFixed(3);
        }
        else {
            var AmountIdText1 = Id.replace('ddlDiscount', 'lblAmount');
            var InvAmountIdText1 = Id.replace('ddlDiscount', 'lblInvAmount');
            document.getElementById(AmountIdText1).innerHTML = document.getElementById(InvAmountIdText1).innerHTML;
            var InvDisAmountIdText = Id.replace('ddlDiscount', 'lblDisAmount');
            document.getElementById(InvDisAmountIdText).innerHTML = "0.000";
            //alert('Please select the Invoice...!');
            var TypeId = document.getElementById(Id);
            TypeId.options[TypeId.selectedIndex] = 0;
            return false;
        }
    }
</script>

<script src="../Scripts/CollectSample.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>